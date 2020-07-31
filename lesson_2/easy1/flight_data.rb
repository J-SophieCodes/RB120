=begin
There is nothing technically incorrect about this class, but 
the definition may lead to problems in the future. How can 
this class be fixed to be resistant to future problems?
=end

class Flight
  attr_reader :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end