# frozen_string_literal: true

module CobraButton
  class CobraButtonComponent < ViewComponent::Base
    def initialize(
        text:,
        id: nil,
        submit: false,
        href: nil,
        onclick: nil,
        return_to: false,
        close_modal: false,
        enable_turbo: true
      )
      @type = submit ? 'submit' : 'button'
      @text = text
      @id = id
      @href = href
      @onclick = onclick
      @enable_turbo = enable_turbo
      
      if (onclick != nil)
        @onclick += "()"
      end
      
      @data_action = nil
      if (close_modal) then
        @data_action = 'cobra-modal#hideModal'
        @enable_turbo = false
      end
    end
  end
end
