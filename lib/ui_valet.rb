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

    def target_element
      {
        button: lambda { |text| driver.button_exact(text) },
        button_contains: lambda { |text| driver.button(text) }
        # name: lambda { |text| driver.button_exact(text) }
      }[@selector]&.call(@selector_text) || driver.find_element({@selector => @selector_text})
    end

    def repeat
      @number_of_repetitions ||= 0
      @number_of_repetitions += 1
      repeat?
    end

    def do_not_repeat
      @number_of_repetitions = 3
      repeat?
    end

    def repeat?
      @number_of_repetitions < 3
    end

    def default_selector
      :name
    end
  end
end