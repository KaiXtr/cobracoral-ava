# frozen_string_literal: true

class MenuPerfilComponent < ViewComponent::Base
  def initialize(usuario_autenticado:)
    @usuario_autenticado = usuario_autenticado
  end
end
