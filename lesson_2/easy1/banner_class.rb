=begin
Behold this incomplete class for constructing boxed banners.

Complete this class so that the test cases shown below work as intended. 
You are free to add any methods or instance variables you need. However, 
do not make the implementation details public.

You may assume that the input will always fit in your terminal window.
=end

class Banner
  def initialize(message, width = message.length)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def fill(pat)
    pat * (@width + 2)
  end

  def horizontal_rule
    "+#{fill("-")}+"
  end

  def empty_line
    "|#{fill(" ")}|"
  end

  def message_line
    "| #{@message.center(@width)} |"
  end
end


# Test Cases
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

banner = Banner.new('Set a fixed banner width.', 50)
puts banner
# +----------------------------------------------------+
# |                                                    |
# |             Set a fixed banner width.              |
# |                                                    |
# +----------------------------------------------------+