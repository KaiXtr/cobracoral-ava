# frozen_string_literal: true

class BarraLateralPreferenciasComponent < ViewComponent::Base
    def initialize(preferencias_usuario:)
        @preferencias_usuario = preferencias_usuario
    end
end
