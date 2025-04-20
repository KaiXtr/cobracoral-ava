# frozen_string_literal: true

class CancelarSalvarButtonsComponent < ViewComponent::Base
  def initialize(
    cancel_to_link: nil,
    close_modal: false)

    @close_modal = close_modal
    
    if cancel_to_link then
      @cancel_url = cancel_to_link
    end
  end
end
