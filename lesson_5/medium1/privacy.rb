class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def current_state
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

hairdryer = Machine.new
hairdryer.start
puts hairdryer.current_state
hairdryer.stop
puts hairdryer.current_state