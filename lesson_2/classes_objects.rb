# Given the below usage of the Person class, code the class definition.

class Person
  attr_accessor :first_name, :last_name
  def initialize(full_name)
    parse_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_name(full_name)
  end

  def parse_name(full_name)
    @first_name, @last_name = full_name.split
    @last_name = @last_name.to_s
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith") 
puts "The person's name is: #{bob}"