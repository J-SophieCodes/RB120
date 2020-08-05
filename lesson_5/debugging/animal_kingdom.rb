class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  # THIS IS UNNECESSARY AS IT'S ALREADY BEEN INHERITED
  # def initialize(diet, superpower)
  #   super
  # end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end

  def sing
    puts @song
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

unicornfish.move
unicornfish.superpower
penguin.move
penguin.superpower
robin.move
robin.superpower
robin.sing

=begin
animal_kingdom.rb:2:in `initialize': wrong number of arguments 
(given 3, expected 2) (ArgumentError)
=end