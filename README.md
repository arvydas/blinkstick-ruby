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
ruby example-info.py
```
