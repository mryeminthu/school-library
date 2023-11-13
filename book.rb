class Book < Nameable
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    super()
    @title = title
    @author = author
    @rentals = []
  end

  def to_s
    "Title: #{@title}, Author: #{@author}"
  end

  def add_rental(rental)
    @rentals << rental
  end

  def to_h
    {
      'title' => @title,
      'author' => @author,
      'rentals' => @rentals.map(&:date)
    }
  end
end
