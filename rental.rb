require_relative 'book'
require_relative 'person'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
    person&.rentals&.push(self)
    book&.rentals&.push(self)
  end

  def to_h
    {
      'date' => date,
      'book' => book&.to_h,
      'person' => person&.to_h
    }
  end

  def self.from_h(data)
    book_data = data['book']
    person_data = data['person']

    book = book_data ? Book.new(book_data['title'], book_data['author']) : nil
    person = RentalData.load_person(person_data)

    Rental.new(data['date'], person, book)
  end
end
