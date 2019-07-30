require_relative 'input_valet'
require_relative 'control_valet'
require_relative 'check_valet'
require 'appium_lib'

module AppiumValet
  class Appium::Driver
    def enter(text)
      InputValet.new(text)
    end

    def click(value = nil, **kvargs)
      ControlValet.new(value, kvargs)
    end

    def check(text, **kvargs)
      CheckValet.new(text, kvargs)
    end
  end
end
