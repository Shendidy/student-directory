# let's put all students into an array
def input_students
  puts "Please enter the names of the studentds and their cohort seperated by a star '*' and no spaces"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first entry
  entry = gets.chomp.split("*")
  # while the entry is not empty, repeat ths code
  while !entry.empty? do
    # add the student hash to the array
    students << {name: entry[0], cohort: entry[1]}
    puts "Now we have #{students.count} student#{students.count == 1 ? "" : "s"}"
    # get another entry from the user
    entry = gets.chomp.split("*")
  end
  # return the array of studentds
  students
end
def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end
def print(names)
  i = 0
  while i < names.count do
    puts "#{(i+1).to_s}. #{names[i][:name]} (#{names[i][:cohort]} cohort)".center(50)
    i += 1
  end
end
def print_footer(names)
  puts names.count>0 ? "Overall, we have #{names.count} great students".center(50) : "We have no students yet!".center(50)
end
students = input_students
print_header
print(students)
print_footer(students)
