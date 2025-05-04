# frozen_string_literal: true

class BarraLateralPreferenciasComponent < ViewComponent::Base
    def initialize(preferencias_usuario:, usuario_autenticado:)
        @preferencias_usuario = preferencias_usuario
        @usuario_autenticado = usuario_autenticado
    end
end
