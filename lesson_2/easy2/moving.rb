# modify the code so that this works
# You are only allowed to write one new method to do this.

# ADDING A MODULE = more appropriate
module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

# ADDING A SUPERCLASS
# class Livingthings
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def walk
#     puts "#{name} #{gait} forward"
#   end
# end

# class Person < Livingthings
#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat < Livingthings
#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah < Livingthings
#   private

#   def gait
#     "runs"
#   end
# end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"