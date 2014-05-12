require "libusb"
require "color"

class BlinkStick
  @@VENDOR_ID = 0X20A0
  @@PRODUCT_ID = 0x41E5

  def open(device = nil)
    @@usb ||= LIBUSB::Context.new

    if (device)
      @device = device
    else
      @device = @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).first
    end

    @handle = @device.open
  end

  def self.find_all
    @@usb ||= LIBUSB::Context.new

    result = []

    @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).each { | device |
      b = BlinkStick.new
      b.open(device)

      result.push(b)
    }

    result
  end

  def self.find_by_serial(serial)
    @@usb ||= LIBUSB::Context.new

    @@usb.devices(:idVendor => @@VENDOR_ID, :idProduct => @@PRODUCT_ID).each { | device |
      if device.serial_number == serial
        b = BlinkStick.new
        b.open(device)
        return b
      end
    }

    nil
  end

  def color=(value)
    @handle.control_transfer(:bmRequestType => 0x20, :bRequest => 0x9, :wValue => 0x1, :wIndex => 0x0000, :dataOut => 1.chr + value.red.to_i.chr + value.green.to_i.chr + value.blue.to_i.chr)
  end

  def color
    result = @handle.control_transfer(:bmRequestType => 0x80 | 0x20, :bRequest => 0x1, :wValue => 0x1, :wIndex => 0x0000, :dataIn => 4)
    Color::RGB.new(result[1].ord, result[2].ord, result[3].ord)
  end

  def set_color(channel, index, value)
    attempts = 0
    while attempts < 5
      attempts += 1

      begin
        @handle.control_transfer(:bmRequestType => 0x20,
                                 :bRequest => 0x9,
                                 :wValue => 0x5,
                                 :wIndex => 0x0000,
                                 :dataOut => 1.chr + channel.to_i.chr + index.to_i.chr + value.red.to_i.chr + value.green.to_i.chr + value.blue.to_i.chr)
        break
      rescue
        if attempts == 5
          raise
        end
      end
    end
  end

  def set_colors(channel, data)
    report_id = 9
    max_leds = 64

    if data.size <= 8 * 3
        max_leds = 8
        report_id = 6
    elsif data.size <= 16 * 3
        max_leds = 16
        report_id = 7
    elsif data.size <= 32 * 3
        max_leds = 32
        report_id = 8
    elsif data.size <= 64 * 3
        max_leds = 64
        report_id = 9
    end

    report = report_id.chr + channel.to_i.chr

    (0..max_leds * 3 - 1).each do | i |
      if data.size > i
        report += data[i].to_i.chr
      else
        report += 0.chr
      end
    end

    #Debug code
    #puts report.unpack('U'*report.length).collect {|x| x.to_s 16}.join(" ")

    attempts = 0
    while attempts < 5
      attempts += 1

      begin
        @handle.control_transfer(:bmRequestType => 0x20,
                                 :bRequest => 0x9,
                                 :wValue => report_id,
                                 :wIndex => 0,
                                 :dataOut => report)
        break
      rescue
        if attempts == 5
          raise
        end
      end
    end
  end

  def off
    self.color = Color::RGB.new(0, 0, 0)
  end

  def get_info_block(id)
    bytes = @handle.control_transfer(:bmRequestType => 0x80 | 0x20, :bRequest => 0x1, :wValue => id + 1, :wIndex => 0x0000, :dataIn => 33)

    result = ""
    for i in 1..(bytes.length-1)
      if i == "\x00"
        break
      end
      result += bytes[i] 
    end

    result
  end

  def set_info_block(id, data)
    data = (id + 1).chr + data
    data = data + 0.chr while data.length < 33
    @handle.control_transfer(:bmRequestType => 0x20, :bRequest => 0x9, :wValue => id + 1, :wIndex => 0x0000, :dataOut => data)
  end

  def random_color
    r = Random.new
    self.color = Color::RGB.new(r.rand(255), r.rand(255), r.rand(255))
  end

  def serial
    @device.serial_number
  end

  def manufacturer
    @device.manufacturer
  end

  def description
    @device.product
  end

  def info_block1
    get_info_block(1)
  end

  def info_block1=(value)
    set_info_block(1, value)
  end

  def info_block2
    get_info_block(2)
  end

  def info_block2=(value)
    set_info_block(2, value)
  end
end
