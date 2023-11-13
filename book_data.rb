class BookData
  DATA_FILE = File.expand_path('data/books.json', __dir__)

  def self.save_books(books)
    File.write(DATA_FILE, JSON.generate(books.map(&:to_h)))
  end

  def self.load_books
    return [] unless File.exist?(DATA_FILE)

    JSON.parse(File.read(DATA_FILE)).map { |book_data| build_book(book_data) }
  end

  def self.build_book(book_data)
    book = Book.new(book_data['title'], book_data['author'])
    load_rentals(book_data).each { |rental_data| build_rental(rental_data, book) }
    book
  end

  def self.load_rentals(book_data)
    book_data['rentals'].to_a
  end

  def self.build_rental(rental_data, book)
    date = rental_data['date']
    person_id = rental_data['person'] && rental_data['person']['id']
    person = PersonData.load_people.find { |p| p.id == person_id }
    rental = Rental.new(::Date.strptime(date, '%Y-%m-%d'), person, book) if person
    book.add_rental(rental) if rental
  end
end
