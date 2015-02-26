require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./colors"

def fade(b, from, to)
  red_diff = to.red - from.red
  green_diff = to.green - from.green
  blue_diff = to.blue - from.blue

  red = from.red
  green = from.green
  blue = from.blue

  # min_diff = [red_diff.abs, green_diff.abs, blue_diff.abs].min
  iter = 30
  (1..iter).each do |i|
    red += red_diff / iter
    green += green_diff / iter
    blue += blue_diff / iter
    b.set_colors(0, [green, red, blue] * 4)
    sleep 0.05
  end
end

def run
  b = BlinkStick.find_all.first
  b.set_colors(0, [255, 0, 0] * 4)
  calls = SkypeCalls.new

  while true
    if calls.new_active?
      fade(b, GREEN, RED)
      calls.update
    elsif calls.finished?
      fade(b, RED, GREEN)
      calls.update
    end

    sleep 0.05
  end
end

if $0 == __FILE__
  run()
end
