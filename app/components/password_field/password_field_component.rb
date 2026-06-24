# frozen_string_literal: true

module PasswordField
  class PasswordFieldComponent < ViewComponent::Base
    def initialize(id:, form:, val:, placeholder: '')
      @id = id
      @form = form
      @val = val
      @placeholder = placeholder
    end
  end
end
