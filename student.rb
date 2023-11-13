require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age:, classroom: nil, name: 'Unknown', parent_permission: true, id: nil)
    super(age: age, name: name, parent_permission: parent_permission, id: id)
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
