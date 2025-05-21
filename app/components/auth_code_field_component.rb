# frozen_string_literal: true

class AuthCodeFieldComponent < ViewComponent::Base
    def initialize()
      @auth_code_digits = 1..6
    end
end
