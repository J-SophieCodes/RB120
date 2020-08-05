# class CircularQueue
#   attr_accessor :buffer_size, :queue, :index
#   def initialize(buffer_size)
#     @buffer_size = buffer_size
#     @queue = Array.new(buffer_size)
#     @index = 0
#   end

#   def enqueue(num)
#     queue[index] = num
#     self.index = update_idx(1)
#   end

#   def dequeue
#     buffer_size.times do |i|
#       next if queue[update_idx(i)].nil?
#       removed, queue[update_idx(i)] = queue[update_idx(i)], nil
#       return removed
#     end
#     nil
#   end

#   def update_idx(i)
#     (index + i) % buffer_size
#   end
# end

#==================================
# FURTHER EXPLORATION:
class CircularQueue
  attr_reader :buffer_size
  attr_accessor :queue

  def initialize(buffer_size)
    @buffer_size = buffer_size
    @queue = []
  end

  def enqueue(num)
    queue << num
    dequeue if queue_limit_exceeded?
  end

  def dequeue
    queue.shift
  end

  def queue_limit_exceeded?
    queue.size > buffer_size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil