require_relative "../blinkstick-ruby/blinkstick"
require_relative "./skype_calls"
require_relative "./strip"

if $0 == __FILE__
  Strip.new(active: 12, colors: EXTENDED_RAINBOW).run
end
