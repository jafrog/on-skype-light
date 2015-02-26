require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./colors"

class Strip
  attr_accessor :b, :calls, :colors, :active, :default_colors

  def initialize(active: 8, colors: RAINBOW)
    @b = BlinkStick.find_all.first
    @colors = @default_colors = colors
    @b.set_colors(0, @colors)
    @active = active

    @calls = SkypeCalls.new
  end

  def rainbow
    @b.set_colors(0, @default_colors)
  end

  def pulse_red
    @colors = ARED * active
    ar = (1..active).to_a.reverse
    ar = ar + ar.reverse
    ar.each do |i|
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

