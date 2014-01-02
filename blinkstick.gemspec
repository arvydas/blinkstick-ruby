# -*- encoding: utf-8 -*-
 $:.push File.expand_path("../lib", __FILE__)
 require "blinkstick/version"

Gem::Specification.new do |s|
  s.name        = "blinkstick"
  s.version     =  BlinkStick::VERSION
  s.date        = "2014-01-02"
  s.summary     = "Blinkstick"
  s.description = <<-DESC
    BlinkStick provides a ruby interface to an Agile Innovative BlinkStick via libusb.

    see ./examples for more info.

    require "blinkstick"

    BlinkStick.find_all.do { | b |
      b.random_color
      puts b.serial + ": " + b.color.html
    end
    ```
  DESC
  s.files       = Dir.glob("{lib}/**/*")
  s.require_path = "lib"
  s.authors = ["Arvydas Juskevicius <arvydas@agileinnovative.co.uk>"]

  s.add_runtime_dependency "libusb", [">= 0.4.0"]
  s.add_runtime_dependency "color", [">= 1.4.2"]
end
