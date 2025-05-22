# frozen_string_literal: true

include MensagensHelper

class MessengerUserButtonComponent < ViewComponent::Base
  def initialize(usuario_autenticado:, usuario_messenger:, selected_id:, action_name:)
    @usuario_autenticado = usuario_autenticado
    @usuario_messenger = usuario_messenger

    if @usuario_messenger.kind_of? Turma then
      @turma_url = '/turma'
      @usuario_nome = @usuario_messenger.nome_turma
      @mensagem_selecionada = action_name == 'turma' \
        && @usuario_messenger.id == selected_id \
        ? 'mensagem-selecionada' : ''
      @mensagens_novas = ''
      @mensagem_recente = ''
    else
      @turma_url = ''
      @usuario_nome = @usuario_messenger.nome_completo
      @mensagem_selecionada = action_name == 'index' \
        && @usuario_messenger.id == selected_id \
        ? 'mensagem-selecionada' : ''
      @mensagens_novas = mensagens_novas_usuario(
        @usuario_autenticado,
        @usuario_messenger
        )
      @mensagem_recente = mensagem_recente_usuario(
        @usuario_autenticado,
        @usuario_messenger
        )
    end
  end
end
