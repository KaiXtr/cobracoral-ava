# frozen_string_literal: true

class CobraButtonComponent < ViewComponent::Base
  def initialize(
      text:,
      submit: false,
      href: nil,
      onclick: nil
    )
    @type = submit ? 'submit' : 'button'
    @text = text
    @href = href
    @onclick = onclick
  end
end
