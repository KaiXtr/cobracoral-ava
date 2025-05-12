# frozen_string_literal: true

class MenuPerfilComponent < ViewComponent::Base
  def initialize(usuario_autenticado:)
    @usuario_autenticado = usuario_autenticado
    @preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: @usuario_autenticado.id)
  end
end
