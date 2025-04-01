# frozen_string_literal: true

class ConteudoNavButtonComponent < ViewComponent::Base
  def initialize(conteudoAtual:, proximoConteudo:)
    @conteudoAtual = conteudoAtual
    @proximoConteudo = proximoConteudo
  end
end
