class FixedArray
  attr_reader :length
  attr_accessor :array

  def initialize(length)
    @length = length
    @array = Array.new(5)
  end

  def [](index)
    raise IndexError if error?(index)
    array[index]
    # @array.fetch(index) would raises an IndexError exception 
    # if the index is out range
  end

  def []=(index, value)
    # self[index] would reuse #fetch to raise IndexError
    raise IndexError if error?(index)
    array[index] = value
  end

  def to_a
    array.clone
  end

  def to_s
    to_a.to_s
  end

  def error?(index)
    index > length - 1 || index < -length
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end