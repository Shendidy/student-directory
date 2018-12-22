# let's put all students into an array
def input_students
  puts "Please enter the names, hobby, country of birth, height, and cohort of the studentds seperated by a star '*' and no spaces"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first entry
  entry = gets.strip.split("*")
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
    students << {name: entry[0], hobby: entry[1] == "" ? "None" : entry[1], country: entry[2] == "" ? "None" : entry[2], height: entry[3] == "" ? "None" : entry[3], cohort: entry[4]}
    puts "Now we have #{students.count} student#{students.count == 1 ? "" : "s"}"
    # get another entry from the user
    entry = gets.strip.split("*")
  end
  # return the array of studentds
  students
end
def print_header
  puts
  puts "The students of Villains Academy".center(120)
  puts "-------------".center(120)
end
def print(students)
  cohorts = []
  students.each do |student|
    if !cohorts.include?(student[:cohort])
      cohorts << student[:cohort]
    end
  end

  i = 1
  cohorts.each do |month|
    puts "In #{month}'s cohort we have:"
    students.each do |student|
      if student[:cohort] == month
        puts "#{(i).to_s}. #{student[:name]} (hobby: #{student[:hobby]}, country of birt: #{student[:country]}, height: #{student[:height]}, #{student[:cohort]} cohort)".center(120)
        i += 1
      end
    end
  end
end
def print_footer(names)
  puts names.count>0 ? "Overall, we have #{names.count} great students".center(120) : "We have no students yet!".center(120)
  puts
end
students = input_students
print_header
print(students)
print_footer(students)
