# frozen_string_literal: true

class OpenModalButtonComponent < ViewComponent::Base
  def initialize(href:, tooltip: "Criar")
    @href = href
    @tooltip = tooltip
  end
end
