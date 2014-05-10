require "optparse"
require "./blinkstick.rb"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example-pro.rb [options]"

  opts.on('-h', '--channel CHANNEL', 'Channel number (R=0, G=1, B=2)') { |v| options[:channel] = v }
  opts.on('-i', '--index INDEX', 'LED index on the channel (0..63)') { |v| options[:index] = v }
  opts.on('-c', '--color COLOR', 'The color to set (00ff00)') { |v| options[:color] = v }

end.parse!

if options[:channel] == nil
  print 'Enter channel (R=0, G=1, B=2): '
  options[:channel] = gets.chomp
end

if options[:index] == nil
  print 'Enter index (0..63): '
  options[:index] = gets.chomp
end

if options[:color] == nil
  print 'Enter color (00ff00): '
  options[:color] = gets.chomp
end

b = BlinkStick.find_all.first
b.set_color(options[:channel], options[:index], Color::RGB.from_html(options[:color]))
