require "./blinkstick.rb"

puts "Display BlinkStick Name (InfoBlock1)"
puts "(c) Agile Innovative Ltd"
puts ""

bstick = BlinkStick.new
bstick.open

bstick.info_block1 = "Ruby Controlled BlinkStick"
puts "InfoBlock1 read: " + bstick.info_block1
