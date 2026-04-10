# frozen_string_literal: true

module AuthCodeField
  class AuthCodeFieldComponent < ViewComponent::Base
      def initialize()
        @auth_code_digits = 1..6
      end
  end
end
