require "./blinkstick.rb"

puts "Find BlinkStick by serial number"
puts "(c) Agile Innovative Ltd"
puts ""

bstick = BlinkStick.find_by_serial("BS000000-1.0")

if bstick
    puts "BlinkStick found. Current color: " + bstick.color.html
else 
    puts "Not found..."
end
