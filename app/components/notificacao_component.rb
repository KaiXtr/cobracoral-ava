# frozen_string_literal: true

class NotificacaoComponent < ViewComponent::Base
  def initialize(mensagem:)
    @mensagem = mensagem
  end
end
