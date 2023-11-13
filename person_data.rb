class PersonData
  DATA_FILE = File.expand_path('data/people.json', __dir__)

  def self.save_people(people)
    File.write(DATA_FILE, JSON.generate(people.map(&:to_h)))
  end

  def self.load_people
    return [] unless File.exist?(DATA_FILE)

    JSON.parse(File.read(DATA_FILE)).map do |person_data|
      person = if person_data['specialization']
                 Teacher.new(specialization: person_data['specialization'], age: person_data['age'],
                             name: person_data['name'], id: person_data['id'])
               else
                 Student.new(
                   classroom: nil,
                   age: person_data['age'],
                   name: person_data['name'],
                   parent_permission: person_data['parent_permission'],
                   id: person_data['id']
                 )
               end

      person.rentals = load_rentals_for_person(person_data['id'])

      person
    end
  end

  def self.load_rentals_for_person(person_id)
    rental_data = RentalData.load_rentals
    rental_data.select { |rental| rental.person&.id == person_id }
  end
end
