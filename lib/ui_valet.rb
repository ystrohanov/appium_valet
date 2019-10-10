module AppiumValet
  class UIValet
    def initialize(text_or_hash, selector: :button, **kvargs)
      super()

      @selector_text = text_or_hash
      @selector = default_selector

      if text_or_hash.is_a? Hash
        text_or_hash.find { |k, v| @selector = k; @selector_text = v }
      end

      kvargs.find { |k, v| @selector = k; @selector_text = v }

      @wait_times = { no_wait: 0.01, a_little: 0.5, a_sec: 1, a_few: 2, a_bunch: 3, a_lot: 5 }
      @after_wait = 0.01
      @before_wait = 0
    end

    def after_wait(wait_time = :no_wait)
      @after_wait = @wait_times[wait_time]
      return self
    end

    def before_wait(wait_time = :no_wait)
      @before_wait = @wait_times[wait_time]
      return self
    end

    def eventually
      @after_wait = 30
      return self
    end

    def exactly(number_of_elements)
      @expected_number_of_elements = number_of_elements
      return self
    end

    def number_of_elements
      @expected_number_of_elements
    end

    def target_element
      @selector = :texts unless number_of_elements.nil?
      {
        button: lambda { |text| driver.button_exact(text) },
        button_contains: lambda { |text| driver.button(text) },
        text: lambda { |text| driver.text_exact(text) },
        text_contains: lambda { |text| driver.text(text) },
        texts: lambda { |text| driver.texts_exact(text) },
        texts_contains: lambda { |text| driver.texts(text) },
        # name: lambda { |text| driver.button_exact(text) }
      }[@selector]&.call(@selector_text) || driver.find_element({@selector => @selector_text})
    end
    alias :element :target_element

    def repeat!
      return true if repeat
      raise """
        Failed: was unable to find element of selector: `#{@selector}`, value: `#{@selector_text}`.
        Number of tries exceeded limit.
        """
    end

    def repeat
      @number_of_repetitions ||= 0
      @number_of_repetitions += 1
      repeat?
    end

    def do_not_repeat
      @number_of_repetitions = max_number_of_tries
      repeat?
    end

    def repeat?
      @number_of_repetitions < max_number_of_tries
    end

    def limit_tries(max)
      @max_number_of_tries = max || 3
      return self
    end

    def max_number_of_tries
      @max_number_of_tries ||= 3
    end

    def default_selector
      return :name if driver.device_is_ios?
      return :text if driver.device_is_android?
    end
  end
end