# frozen_string_literal: true

class BarraPrincipalComponent < ViewComponent::Base
  def initialize(usuario_autenticado:)
    @usuario_autenticado = usuario_autenticado

    if Rails.env.test?
      @cobracoral_env = ' (TEST)'
    end
    if Rails.env.development?
      @cobracoral_env = ' (DEVEL)'
    end
  end
end
