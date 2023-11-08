require_relative 'nameable'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'
require 'date'

class SchoolLibraryApp
  attr_accessor :people_list, :book_list, :rental_list

  def initialize
    @people_list = []
    @book_list = []
    @rental_list = []
  end

  def display_menu
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def list_books
    puts 'List of books:'
    book_list.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts 'List of people:'
    people_list.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number 1 or 2]:'
    person_type = gets.chomp.to_i

    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    if person_type == 1
      create_student(age, name)
    elsif person_type == 2
      create_teacher(age, name)
    else
      puts 'Invalid choice. Please choose a valid option (1 for student, 2 for teacher).'
    end
  end

  def create_student(age, name)
    puts 'Has parent permission? [Y/N]:'
    parent_permission_input = gets.chomp.downcase
    parent_permission = parent_permission_input == 'y'

    student = Student.new(classroom: nil, age: age, name: name, parent_permission: parent_permission)
    people_list << student
    puts 'Student created successfully!'
  end

  def create_teacher(age, name)
    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(specialization: specialization, age: age, name: name)
    people_list << teacher
    puts 'Teacher created successfully!'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp

    puts 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    book_list << book
    puts 'Book created successfully!'
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    list_books

    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id):'
    list_people

    person_index = gets.chomp.to_i

    puts 'Date (yyyy/mm/dd):'
    date_str = gets.chomp

    book = book_list[book_index]
    person = people_list[person_index]

    rental = Rental.new(::Date.strptime(date_str, '%Y/%m/%d'), person, book)
    rental_list << rental

    puts 'Rental created successfully!'
  end

  def list_rentals_for_person
    puts 'ID of person:'
    person_id = gets.chomp.to_i

    person = people_list.find { |p| p.id == person_id }

    if person
      puts 'Rentals:'
      rentals = rental_list.select { |r| r.person == person }
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
      end
    else
      puts "Person with ID #{person_id} not found."
    end
  end
end
