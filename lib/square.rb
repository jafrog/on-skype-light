require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./colors"

class Square
  attr_accessor :b, :colors, :active, :calls

  def initialize
    @b = BlinkStick.find_all.first
    @active = 4
    @colors = AGREEN * active
    @b.set_colors(0, @colors)

    @calls = SkypeCalls.new
  end

  def fade_to(to)
    iter = 30.0
    from = @colors[0,3]

    puts "from: #{from}; to: #{to}"

    red_inc   = (to[0] - from[0]) / iter
    green_inc = (to[1] - from[1]) / iter
    blue_inc  = (to[2] - from[2]) / iter

    puts "red_inc: #{red_inc}; green_inc: #{green_inc}; blue_inc: #{blue_inc}"

    red = from[0]
    green = from[1]
    blue = from[2]

    (1..iter).each do |i|
      red += red_inc
      green += green_inc
      blue += blue_inc

      @colors = [red, green, blue] * active
      b.set_colors(0, colors)

      sleep 0.05
    end
  end

  def red
    fade_to(ARED)
  end

  def pulse_red
    fade_to(ARED)
    sleep 0.05
    fade_to(AWHITE)
  end

  def green
    fade_to(AGREEN)
  end

  def run
    while true
      if calls.ringing?
        pulse_red
      elsif calls.inprogress?
        red
      elsif calls.finished_or_missed?
        green
      end

      sleep 0.05
    end
  end
end

if $0 == __FILE__
  Square.new.run
end
