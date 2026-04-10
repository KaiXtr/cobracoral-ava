# frozen_string_literal: true

module OpenModalButton
  class OpenModalButtonComponent < ViewComponent::Base
    def initialize(href:,
      button_class: nil,
      tooltip: "Criar",
      open_modal: true,
      selectable: true)
      @href = href
      @button_class = button_class
      @tooltip = tooltip
      @open_modal = open_modal
      @selectable = selectable
    end
  end
end
