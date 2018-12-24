@students = [] # an empty array accessible to all methods

# let's put all students into an array
def input_students
  puts "Please enter the names, hobby, country of birth, height, and cohort of the studentds seperated by a star '*' and no spaces"
  puts "To finish, just hit return twice"
            # create an empty array
            # students = []
  # get the first entry
  entry = gets.chomp.split("*")
  # while the entry is not empty, repeat ths code
  while !entry.empty? do
    # ensure that there are 5 infoes for each entry
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
          entry[i] = "january"
        end
        i += 1
      end
    end
    # get cohort and turn into a symbol (if empty then make assumption it's January)
    entry[4].downcase!
    case entry[4]
    when "january"
      entry[4] = :January
    when "february"
      entry[4] = :February
    when "march"
      entry[4] = :March
    when "april"
      entry[4] = :April
    when "may"
      entry[4] = :May
    when "june"
      entry[4] = :June
    when "july"
      entry[4] = :July
    when "august"
      entry[4] = :August
    when "september"
      entry[4] = :September
    when "october"
      entry[4] = :October
    when "november"
      entry[4] = :November
    when "december"
      entry[4] = :December
    else
      puts "Wrong cohort entered, we set it to the default of January"
      entry[4] = :January
    end
    # add the student hash to the array
    @students << {name: entry[0], hobby: entry[1] == "" ? "None" : entry[1], country: entry[2] == "" ? "None" : entry[2], height: entry[3] == "" ? "None" : entry[3], cohort: entry[4]}
    puts "Now we have #{@students.count} student#{@students.count == 1 ? "" : "s"}"
    # get another entry from the user
    entry = gets.chomp.split("*")
  end
end




def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of studentds
  @students.each do |student|
    student_data = [student[:name], student[:hobby], student[:country], student[:height], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
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
        puts "#{(i).to_s}. #{student[:name]} (hobby: #{student[:hobby]}, country of birt: #{student[:country]}, height: #{student[:height]}, #{student[:cohort]} cohort)".center(120)
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
  puts "1. Input the students list"
  puts "2. Show the students list"
  puts "3. Save the list to students.csv"
  puts "9. Exit" # 9 because we'll be adding more items/options/choices
end
def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
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
    process(gets.chomp)
  end
end

interactive_menu
