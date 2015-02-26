require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./colors"

class Strip
  attr_accessor :b, :calls, :colors, :active

  def initialize
    @b = BlinkStick.find_all.first
    @colors = RAINBOW
    @b.set_colors(0, @colors)
    @active = 8

    @calls = SkypeCalls.new
  end

  def rainbow
    @colors = RAINBOW
    @b.set_colors(0, @colors)
  end

  def pulse_red
    @colors = ARED * active
    [8,7,6,5,4,5,6,7,8].each do |i|
      b.set_colors(0, ARED * i)
      sleep 0.05
    end
  end

  def red
    @colors = ARED * active
    b.set_colors(0, @colors)
  end


  def run
    while true
      if calls.ringing?
        pulse_red
      elsif calls.inprogress?
        red
      elsif calls.finished_or_missed?
        rainbow
      end

      sleep 0.05
    end
  end
end

if $0 == __FILE__
  Strip.new.run
end

