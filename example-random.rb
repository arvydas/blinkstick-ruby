require "./blinkstick.rb"

puts "Set random BlinkStick color"
puts "(c) Agile Innovative Ltd"
puts ""

BlinkStick.find_all.each { | b |
  b.random_color
  puts b.serial + ": " + b.color.html
}
