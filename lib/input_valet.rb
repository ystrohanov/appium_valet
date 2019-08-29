require_relative 'ui_valet'

module AppiumValet
  class InputValet < UIValet
    def into(textfield:)
      input_field = textfield_element(textfield)
      input_field.clear
      input_field.send_keys(@selector_text)
    end

    private

    def textfield_element(search_value)
      return driver.textfield(search_value) if driver.device_is_ios?
      return driver.find_element(id: search_value) if driver.device_is_android?
    end
  end
end