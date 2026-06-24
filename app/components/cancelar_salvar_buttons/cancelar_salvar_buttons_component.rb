# frozen_string_literal: true

module CancelarSalvarButtons
  class CancelarSalvarButtonsComponent < ViewComponent::Base
    def initialize(
      cancel_text: 'Cancelar',
      submit_text: 'Salvar',
      cancel_to_link: nil,
      submit_to_link: nil,
      close_modal: false)

      @cancel_text = cancel_text
      @submit_text = submit_text
      @cancel_to_link = cancel_to_link
      @submit_to_link = submit_to_link
      @close_modal = close_modal

      if (close_modal) then
        cancel_to_link = nil
      end
    end
  end
end
