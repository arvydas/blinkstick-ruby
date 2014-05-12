require "optparse"
require "./blinkstick.rb"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example-pro-run.rb [options]"

  opts.on('-h', '--channel CHANNEL', 'Channel number (R=0, G=1, B=2)') { |v| options[:channel] = v }
  opts.on('-l', '--leds LED_COUNT', 'Number of LEDs') { |v| options[:leds] = v }
  opts.on('-c', '--color COLOR', 'The color to set (00ff00)') { |v| options[:color] = v }

end.parse!

if options[:channel] == nil
  print 'Enter channel (R=0, G=1, B=2): '
  options[:channel] = gets.chomp
end

if options[:leds] == nil
  print 'Enter number of LEDs: '
  options[:leds] = gets.chomp
end

if options[:color] == nil
  options[:color] = "ffffff"
end

c = Color::RGB.from_html(options[:color])
black = Color::RGB.new

b = BlinkStick.find_all.first

i = -1
direction = 1
first = true

while true
  i += direction

  #turn off the previous one
  b.set_color(options[:channel], i - direction, black) unless first

  #turn on next one
  b.set_color(options[:channel], i, c)

  #change direction when last LED
  direction = -1 if i == options[:leds].to_i - 1
  direction = 1 if i == 0 && !first

  first = false

  sleep(0.02)
end
#(0..options[:leds].to_i - 1).each { | i |
#  if i > 0
#    b.set_color(options[:channel], i - 1, black)
#  end
#
#  b.set_color(options[:channel], i, c)
#  sleep(0.002)
#}

