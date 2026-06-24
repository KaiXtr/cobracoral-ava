# frozen_string_literal: true

module CobraModal
    class CobraModalComponent < ViewComponent::Base
        include Turbo::FramesHelper

        def initialize(allow_close_background: false)
            @modal_controller = "cobra-modal"
            @modal_target = "cobra-modal"
            @allow_close_background = allow_close_background
            @modal_actions = "turbo:submit-end->cobra-modal#submitEnd
                                keyup@window->cobra-modal#closeWithKeyboard
                                click@window->cobra-modal#closeBackground"
        end
    end
end
