# frozen_string_literal: true

class ContextMenuComponent < ViewComponent::Base
  def initialize(ativado: true)
    @ativado = ativado
  end
end
