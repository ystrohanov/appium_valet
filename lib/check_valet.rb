require_relative 'ui_valet'

module AppiumValet
  class CheckValet < UIValet
    def is_displayed?
      result = wait(@after_wait) { driver.exists { target_element } }

      return false if missed_find_exact_number_of_elements?
      result
    end

    def is_displayed(&block)
      begin
        wait_true(@after_wait) { driver.exists { target_element } }
        if missed_find_exact_number_of_elements?
          raise """
            Failed: was unable to find exactly #{number_of_elements} of: `#{@selector_text}`.
          """
        end
      rescue StandardError => e
        raise(e) if block.nil?
        is_displayed(&block) if block.call(self)
      end

      begin
        wait_true(timeout: @before_wait, interval: 0.5) { false } if @before_wait > 0
      rescue
      end
    end

    def is_enabled?
      wait(@after_wait) { target_element.enabled? }
    end

    def is_enabled(&block)
      wait(@after_wait) { target_element.enabled? }
      begin
        wait_true(@after_wait) { target_element.enabled? }
      rescue StandardError => e
        raise(e) if block.nil?
        is_displayed(&block) if block.call(self)
      end

      begin
        wait_true(timeout: @before_wait, interval: 0.5) { false } if @before_wait > 0
      rescue
      end
    end

    private

    def missed_find_exact_number_of_elements?
      number_of_elements && (target_element.count != number_of_elements)
    end
  end
end
