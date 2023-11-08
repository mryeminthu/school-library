require_relative 'app'

def main
  app = SchoolLibraryApp.new
  puts 'Welcome to the School Library App!'
  loop do
    display_menu
    choice = gets.chomp.to_i
    process_choice(choice, app)
  end
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

# rubocop:disable Metrics/CyclomaticComplexity
def process_choice(choice, app)
  case choice
  when 1
    list_books(app)
  when 2
    list_people(app)
  when 3
    create_person(app)
  when 4
    create_book(app)
  when 5
    create_rental(app)
  when 6
    list_rentals_for_person(app)
  when 7
    exit_app
  else
    invalid_choice
  end
end
# rubocop:enable Metrics/CyclomaticComplexity

def list_books(app)
  app.list_books
end

def list_people(app)
  app.list_people
end

def create_person(app)
  app.create_person
end

def create_book(app)
  app.create_book
end

def create_rental(app)
  app.create_rental
end

def list_rentals_for_person(app)
  app.list_rentals_for_person
end

def exit_app
  puts 'Thank you for using the School Library App!'
  exit
end

def invalid_choice
  puts 'Invalid choice. Please choose a valid option.'
end

main
