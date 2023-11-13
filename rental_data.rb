require 'json'
require_relative 'rental'
require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'

class RentalData
  DATA_FILE = File.expand_path('data/rentals.json', __dir__)

  def self.save_rentals(rentals)
    File.write(DATA_FILE, JSON.generate(rentals.map(&:to_h)))
  end

  def self.load_rentals
    return [] unless File.exist?(DATA_FILE)

    JSON.parse(File.read(DATA_FILE)).map do |rental_data|
      rental = Rental.new(rental_data['date'], nil, nil)
      rental_data['book'] && rental.book = Book.new(rental_data['book']['title'], rental_data['book']['author'])
      rental_data['person'] && rental.person = load_person(rental_data['person'])
      rental
    end
  end

  def self.load_person(person_data)
    return unless person_data.is_a?(Hash)

    if person_data['specialization']
      Teacher.new(specialization: person_data['specialization'], age: person_data['age'], name: person_data['name'])
    else
      Student.new(
        classroom: nil,
        age: person_data['age'],
        name: person_data['name'],
        parent_permission: person_data['parent_permission'],
        id: person_data['id']
      )
    end
  end

  def self.load_rentals_for_person(person_id)
    load_rentals.select { |rental| rental.person&.id == person_id }
  end
end
