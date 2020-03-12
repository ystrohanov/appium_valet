require_relative 'ui_valet'

module AppiumValet
  class ControlValet < UIValet
    def on(&block)
      begin
        wait(@after_wait) { target_element }.click
      rescue StandardError => e
        raise(e) if block.nil?
        on(&block) if block.call(self)
      end

      begin
        wait_true(timeout: @before_wait, interval: 0.5) { false } if @before_wait > 0
      rescue
      end
    end

    def default_selector
      :name
    end
  end
end