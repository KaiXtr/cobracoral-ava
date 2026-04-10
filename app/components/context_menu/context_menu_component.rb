# frozen_string_literal: true

module ContextMenu
  class ContextMenuComponent < ViewComponent::Base
    def initialize(ativado: true)
      @ativado = ativado
      @link = nil
      @anotacoes = false
    end
  end
end
