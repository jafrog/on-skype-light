require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./colors"

class NeoMatrix

  LOGOS = {
    :cross => [
      :r,:r,:x,:x,:x,:x,:r,:r,
      :r,:r,:r,:x,:x,:r,:r,:r,
      :x,:r,:r,:r,:r,:r,:r,:x,
      :x,:x,:r,:r,:r,:r,:x,:x,
      :x,:x,:r,:r,:r,:r,:x,:x,
      :x,:r,:r,:r,:r,:r,:r,:x,
      :r,:r,:r,:x,:x,:r,:r,:r,
      :r,:r,:x,:x,:x,:x,:r,:r
    ],
    :tick => [
      :x,:x,:x,:x,:x,:x,:x,:g,
      :x,:x,:x,:x,:x,:x,:g,:g,
      :x,:x,:x,:x,:x,:g,:g,:x,
      :x,:x,:x,:x,:g,:g,:x,:x,
      :g,:g,:x,:g,:g,:x,:x,:x,
      :g,:g,:g,:g,:x,:x,:x,:x,
      :g,:g,:g,:x,:x,:x,:x,:x,
      :x,:g,:x,:x,:x,:x,:x,:x
    ],
    :otick => [
      :x,:x,:x,:x,:x,:x,:x,:o,
      :x,:x,:x,:x,:x,:x,:o,:o,
      :x,:x,:x,:x,:x,:o,:o,:x,
      :x,:x,:x,:x,:o,:o,:x,:x,
      :o,:o,:x,:o,:o,:x,:x,:x,
      :o,:o,:o,:o,:x,:x,:x,:x,
      :o,:o,:o,:x,:x,:x,:x,:x,
      :x,:o,:x,:x,:x,:x,:x,:x
    ],
    :fa => [
      :b,:x,:x,:x,:b,:b,:x,:x,
      :b,:b,:x,:b,:b,:x,:x,:x,
      :b,:b,:b,:b,:x,:g,:x,:x,
      :x,:x,:b,:b,:x,:g,:x,:x,
      :x,:x,:b,:b,:g,:g,:g,:x,
      :x,:x,:b,:x,:x,:g,:g,:x,
      :x,:b,:b,:x,:x,:x,:g,:g,
      :x,:b,:b,:x,:x,:x,:g,:g
    ],
    :off => [
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x,
      :x,:x,:x,:x,:x,:x,:x,:x
    ]
  }

  def initialize
    @b = BlinkStick.find_all.first
    @calls = SkypeCalls.new
    
    @cur_logo = :off
  end

  def render(logo)
    # Don't both updating if we are displaying the same thing
    return if logo == @cur_logo

    begin
      LOGOS[logo].each_index do |i|
        case LOGOS[logo][i]
        when :w
          color = '#cccccc'
        when :o
          color = '#cccc00'
        when :x
          color = '#000000'
        when :b
          color = '#0000cc'
        when :g
          color = '#00cc00'
        when :r
          color = '#cc0000'
        end
        @b.set_color(0, i, Color::RGB.from_html(color))
        @cur_logo = logo
      end
    rescue Exception
      puts "No errors to see here, move along"
    end
  end

  def run
    calls = SkypeCalls.new

    while true
      if calls.ringing?
        render :fa
      elsif calls.inprogress?
        render :cross
      elsif calls.finished_or_missed?
        render :tick
      end
      sleep 0.05
    end
  end
end

if $0 == __FILE__
  NeoMatrix.new.run
end
