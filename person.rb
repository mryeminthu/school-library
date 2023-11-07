require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :classroom, :rentals

  def initialize(age:, name: 'Unknown', parent_permission: true)
    super()
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @classroom = nil
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students << self
  end

  def add_rental(rental)
    rentals << rental
    rental.person = self
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    rand(1000..9999)
  end
end
