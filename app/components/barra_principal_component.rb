# frozen_string_literal: true

class BarraPrincipalComponent < ViewComponent::Base
  def initialize(usuario_autenticado:)
    @usuario_autenticado = usuario_autenticado

    @novos_comunicados = ReacaoComunicado.where(
      usuario_id: @usuario_autenticado.id,
      emoji: nil
    ).length

    @novas_mensagens = 0
  end
end
