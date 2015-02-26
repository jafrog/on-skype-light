require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./strip"

class Ring < Strip
  def rainbow
    @colors = EXTENDED_RAINBOW
    @b.set_colors(0, @colors)
  end

  def pulse_red
    @colors = ARED * active
    [12,11,10,9,8,9,10,11,12].each do |i|
      b.set_colors(0, ARED * i)
      sleep 0.05
    end
  end
end

if $0 == __FILE__
  Ring.new(active: 12, colors: EXTENDED_RAINBOW).run
end
