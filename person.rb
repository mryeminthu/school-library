class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age:, name: 'Unknown', parent_permission: true, id: nil)
    super()
    @id = id || generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @classroom = nil
    @rentals = []
  end

  def add_rental(date, book)
    rental = Rental.new(date, self, book)
    @rentals << rental
  end

  def to_h
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'rentals' => @rentals.map(&:date)
    }
  end

  private

  def generate_id
    rand(1000..9999)
  end
end
