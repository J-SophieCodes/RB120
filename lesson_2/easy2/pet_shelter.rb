# Write the classes and methods that will be necessary to make this code run

# class Pet
#   attr_reader :species, :name

#   def initialize(species, name)
#     @species = species
#     @name = name
#   end

#   def to_s
#     "a #{species} named #{name}"
#   end
# end

# class Owner
#   attr_reader :name
#   attr_accessor :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def number_of_pets
#     pets.size
#   end
# end

# class Shelter
#   def initialize
#     @owners = []
#   end

#   def adopt(owner, pet)
#     @owners << owner unless @owners.include?(owner)
#     owner.pets << pet
#   end

#   def print_adoptions
#     @owners.each do |owner|
#       puts "#{owner.name} has adopted the following pets:"
#       puts owner.pets
#     end
#   end
# end


# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')

# shelter = Shelter.new
# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.print_adoptions

# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

#===========================================
# FURTHER EXPLORATION

class Pet
  @@all_pets = {}
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
    @@all_pets[self] = "unadopted"
  end

  def self.adopted(pet)
    @@all_pets[pet] = "adopted"
  end

  def to_s
    "a #{animal} named #{name}"
  end

  def self.unadopted
    @@all_pets.keys.select { |pet| @@all_pets[pet] == "unadopted" }
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
    Pet.adopted(pet)
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end

  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    puts Pet.unadopted
    puts
  end

  def number_unadopted
    Pet.unadopted.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
charming     = Pet.new('dog', 'Charming')
xena         = Pet.new('dog', 'Xena')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
shelter.print_unadopted

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.number_unadopted} unadopted pets."