@students = [] # an empty array accessible to all methods

# let's put all students into an array
def input_students
  puts "Please enter the names, hobby, country of birth, height, and cohort of the studentds seperated by a star '*' and no spaces"
  puts "To finish, just hit return twice"
  # get the first entry
  entry = STDIN.gets.chomp.split("*")

  # while the entry is not empty, repeat ths code
  while !entry.empty? do
    # set default entries
    entry = set_entries(entry)

    # set default cohorts
    entry[4] = set_cohort(entry[4].downcase)

    # add the student hash to the array
    read_students(entry)

    puts "Now we have #{@students.count} student#{@students.count == 1 ? "" : "s"}"

    # get another entry from the user
    entry = STDIN.gets.chomp.split("*")
  end
end

def set_entries(entry)
  # ensure that there are 5 entries for each student
  if entry.count < 5
    i = entry.count - 1
    while i < 5
      case i
      when 1
        entry[i] = :None
      when 2
        entry[i] = :None
      when 3
        entry[i] = :None
      when 4
        entry[i] = :January
      end
      i += 1
    end
  end
  return entry
end

def set_cohort(cohort)
  cohorts = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  return cohort.capitalize.to_sym if cohorts.include?(cohort.capitalize)
  puts "Wrong cohort entered, we set it to the default of January"
  return :January
end

def save_students(file_to_save)
  # open the file for writing
  File.open(file_to_save, "a+"){|file|
    # iterate over the array of studentds
    @students.each do |student|
      student_data = [student[:name], student[:hobby], student[:country], student[:height], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  }
end

def load_students(filename)
  if File.exists?(filename)
    File.open(filename, "r") {|file|
      file.readlines.each do |line|
        name, hobby, country, height, cohort = line.chomp.split(',')
        read_students([name, hobby, country, height, cohort.to_sym])
      end
      puts "Loaded #{@students.count} students from #{filename}"
    }
  else
    puts "File doesn't exist!"
  end
end

def try_load_students # checks on startup if a file was passed for loading
  filename = ARGV.first # first argument from the command csv_line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
  else # if it doens't exists
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def clear_list
  @students = []
  puts "List cleared."
end

def read_students(entry)
  # set defaults if fields left empty
  entry[1] = "None" if entry[1] == ""
  entry[2] = "None" if entry[2] == ""
  entry[3] = "None" if entry[3] == ""

  # write a method to be used in all other methods when they want to add students to @students array
  @students << {name: entry[0], hobby: entry[1], country: entry[2], height: entry[3], cohort: entry[4]}
end

def ask_for_file_name(action)
  puts "Which file to #{action}:"
  file = STDIN.gets.chomp

  file == "" ? ask_for_file_name(action) : file
end

def print_header
  puts
  puts "The students of Villains Academy".center(120)
  puts "-------------".center(120)
end

def print_students_list
  cohorts = []
  @students.each do |student|
    if !cohorts.include?(student[:cohort])
      cohorts << student[:cohort]
    end
  end
  i = 1
  cohorts.each do |month|
    puts "In #{month}'s cohort we have:"
    @students.each do |student|
      if student[:cohort] == month
        puts "#{(i).to_s}. #{student[:name]} (hobby: #{student[:hobby]}, country of birth: #{student[:country]}, height: #{student[:height]}, #{student[:cohort]} cohort)".center(120)
        i += 1
      end
    end
  end
end
def print_footer
  puts @students.count>0 ? "Overall, we have #{@students.count} great students".center(120) : "We have no students yet!".center(120)
  puts
end
def print_menu
  puts "1. Input students manually"
  puts "2. Show the list of currently available students"
  puts "3. Save the list currently available students"
  puts "4. Load a list and add to currently available students"
  puts "5. Empty current list"
  puts "9. Exit" # 9 because we'll be adding more items/options/choices
end
def process(selection)
  case selection
  when "1"
    input_students
    puts "Action completed, please choose new action"
  when "2"
    show_students
    puts "Action completed, please choose new action"
  when "3"
    save_students(ask_for_file_name("save"))
    puts "Action completed, please choose new action"
  when "4"
    load_students(ask_for_file_name("load"))
    puts "Action completed, please choose new action"
  when "5"
    puts "Are you sure you want to clear the current list of students? (Y/N)"
    STDIN.gets.chomp == "Y" ? clear_list : return
  when "9"
    puts "Bye"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, please try again"
  end
end
def show_students
  print_header
  print_students_list
  print_footer
end
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
