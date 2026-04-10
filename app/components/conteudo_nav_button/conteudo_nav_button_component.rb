# frozen_string_literal: true

module ConteudoNavButton
  class ConteudoNavButtonComponent < ViewComponent::Base
    def initialize(conteudoAtual:, proximoConteudo:)
      @conteudoAtual = conteudoAtual
      @proximoConteudo = proximoConteudo
    end
  end
end
