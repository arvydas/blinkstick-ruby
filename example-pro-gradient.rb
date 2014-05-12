require "optparse"
require "./blinkstick.rb"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example-pro-8x1.rb [options]"

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

c = Color::RGB.from_html(options[:color]).to_hsl

b = BlinkStick.find_all.first

data = []

(0..options[:leds].to_i - 1).each do | i |
  c.l = 0.01 + 0.125 * i / options[:leds].to_i
  cc = c.to_rgb
  data += [cc.green, cc.red, cc.blue]
end

b.set_colors(options[:channel], data)
