# let's put all students into an array
def input_students
  puts "Please enter the names, hobby, country of birth, height, and cohort of the studentds seperated by a star '*' and no spaces"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first entry
  entry = gets.chomp.split("*")
  # while the entry is not empty, repeat ths code
  while !entry.empty? do
    # add the student hash to the array
    students << {name: entry[0], hobby: entry[1], country: entry[2], height: entry[3], cohort: entry[4]}
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
    puts "#{(i+1).to_s}. #{names[i][:name]} (hobby: #{names[i][:hobby]}, country of birth: #{names[i][:country]}, height: #{names[i][:height]}, #{names[i][:cohort]} cohort)".center(120)
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
