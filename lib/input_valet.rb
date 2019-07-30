require_relative 'ui_valet'

module AppiumValet
  class InputValet < UIValet
    def into(textfield:)
      input_field = driver.textfield(textfield)
      input_field.clear
      input_field.send_keys(@selector_text)
    end
  end
end