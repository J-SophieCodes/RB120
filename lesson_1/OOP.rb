# require 'time'

# class Vehicle
#   @@number_of_objects = 0  # class variable

#   def self.mileage(gallons, miles)  # class method
#     puts "#{miles / gallons} miles per gallon of gas"
#   end

#   def self.total 
#     @@number_of_objects
#   end

#   attr_accessor :year, :model, :color, :speed  # accessor methods

#   def initialize(year, model, color) # contructor / instance method
#     @@number_of_objects += 1
#     @year = year    # instance variable
#     @model = model
#     @color = color
#     @speed = 0
#   end

#   def speed_up(number) # instance method
#     self.speed += number
#     puts "You push the gas and accelerate #{number} mph."
#   end

#   def brake(number)
#     self.speed -= number
#     puts "You push the brake and decelerate #{number} mph."
#   end

#   def current_speed
#     puts "You are now going at #{speed} mph."
#   end

#   def shut_down
#     self.current_speed = 0
#     puts "Let's park this bad boy!"
#   end

#   def spray_paint(color)
#     self.color = color
#     puts "Your new #{color} paint job looks great!"
#   end

#   def to_s
#     "#{color} #{year} #{model}"
#   end

#   def age
#     "The age of the #{self} is #{calculate_age} years"
#   end

#   private

#   def calculate_age
#     Time.now.year - year
#   end
# end

# module FourWheelDrivable
#   def four_wheel_drive
#     "I can drive up mountains!"
#   end
# end

# class MyCar < Vehicle
#   SEATS = 5
# end

# class MyTruck < Vehicle
#   SEATS = 7
#   include FourWheelDrivable
# end

# lumina = MyCar.new(1997, 'chevy lumina', 'white')
# puts lumina.age

# ====================================

# class Student
#   attr_accessor :name

#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(name2)
#     grade > name2.grade
#   end

#   protected

#   attr_reader :grade
# end

# joe = Student.new("joe", 78)
# bob = Student.new("bob", 58)

# puts "Well done!" if joe.better_grade_than?(bob)
