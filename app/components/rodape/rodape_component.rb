# frozen_string_literal: true

module Rodape
  class RodapeComponent < ViewComponent::Base
      def initialize()
        @habilitar_links = true
        
        if Rails.env.test?
          @cobracoral_env = ' (TEST)'
        end
        if Rails.env.development?
          @cobracoral_env = ' (DEVEL)'
        end
      end
  end
end
