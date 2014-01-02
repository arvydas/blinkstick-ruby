require "./blinkstick.rb"

puts "Turn off BlinkStick"
puts "(c) Agile Innovative Ltd"
puts ""

BlinkStick.find_all.each { | b |
  b.off
  puts b.serial + " turned off"
}
