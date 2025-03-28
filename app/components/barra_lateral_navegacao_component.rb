# frozen_string_literal: true

class BarraLateralNavegacaoComponent < ViewComponent::Base
  def initialize(usuario_autenticado:)
    @usuario_autenticado = usuario_autenticado
    @matricula_estudante = Matricula.find_by(usuario_id: @usuario_autenticado.id)
  end
end
