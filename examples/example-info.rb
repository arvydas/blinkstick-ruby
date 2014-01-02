require "./blinkstick.rb"

puts "Display BlinkStick info"
puts "(c) Agile Innovative Ltd"
puts ""

BlinkStick.find_all.each { | b |
  puts "Found device:"
  puts "    Manufacturer:  " + b.manufacturer
  puts "    Description:   " + b.description
  puts "    Serial:        " + b.serial
  puts "    Current Color: " + b.color.html
  puts "    Info Block 1:  " + b.info_block1()
  puts "    Info Block 2:  " + b.info_block2()
}
