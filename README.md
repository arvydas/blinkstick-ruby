BlinkStick Ruby
===============

BlinkStick Ruby interface to control devices connected to the computer.

What is BlinkStick? Check it out here:

http://www.blinkstick.com

Requirements
------------

* Ruby 1.9.3
* LibUSB development libraries
* Color and LibUSB gems

```sh
[sudo] gem install color
[sudo] gem install libusb
```

Note: Please refer to [larskanis/libusb](https://github.com/larskanis/libusb) documentation on how to install the gem on various platforms.

Description
-----------

Description of files:

* blinkstick.rb - main BlinkStick class definition
* example-info.rb - displays information of each BlinkStick
* example-infoblock.rb - read/write info block sample
* example-off.rb - turn all blinksticks off
* example-random.rb - set random color to all blinksticks

Running examples:

```sh
ruby examples/example-info.rb
```

Usage
-----

Add gem "blinkstick" to your Gemfile.
```gem "blinkstick"```

```
require "blinkstick"

BlinkStick.find_all.each { | b |
  b.random_color
  puts b.serial + ": " + b.color.html
}
```

Permission problems
-------------------

If the script returns with an error

```sh
LIBUSB::ERROR_ACCESS in libusb_open
```

You can either run the script with sudo, for example:

```sh
sudo ruby example-info.rb
```

Or you can add a udev rule to allow any user to access the device without root permissions with this single command:

```sh
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"20a0\", ATTR{idProduct}==\"41e5\", MODE:=\"0666\"" | sudo tee /etc/udev/rules.d/85-blinkstick.rules
```

Reboot computer after you have added the command and all users will have permissions to access the device without the need of root permissions.
