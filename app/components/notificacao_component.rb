# frozen_string_literal: true

class NotificacaoComponent < ViewComponent::Base
  def initialize(mensagem:)
    @mensagem = mensagem

    if @mensagem.kind_of?(Array) then
      erros = ""
      @mensagem.each do |erro|
        erros += erro + "\n"
      end
      @mensagem = erros
    end
  end
end
