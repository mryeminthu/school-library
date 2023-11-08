require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age:, classroom: nil, name: 'Unknown', parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    self.classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom&.add_student(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
