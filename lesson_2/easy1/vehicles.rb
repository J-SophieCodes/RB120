# Refactor these classes so they all use a common superclass, 
# and inherit behavior as needed.

# class Vehicles
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Car < Vehicles
#   def wheels
#     4
#   end
# end

# class Motorcycle < Vehicles
#   def wheels
#     2
#   end
# end

# class Truck < Vehicles
#   attr_reader :payload

#   def initialize(make, model, payload)
#     super(make, model)
#     @payload = payload
#   end

#   def wheels
#     6
#   end
# end

#=======================

class Vehicles
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
    @wheels = nil
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    @wheels
  end
end

class Car < Vehicles
  def initialize(make, model)
    super
    @wheels = 4
  end
end

class Motorcycle < Vehicles
  def initialize(make, model)
    super
    @wheels = 2
  end
end

class Truck < Vehicles
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
    @wheels = 6
  end
end

rabbit = Car.new("VW", "Golf")
puts rabbit.wheels