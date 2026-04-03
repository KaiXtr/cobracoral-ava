class ApplicationMailer < ActionMailer::Base
  default from: "noreply@cobracoral.edu.br"
  layout "mailer"

  before_action :set_url_host

  def set_url_host
		if Rails.env.production?
      @mailer_host = "http://localhost:3000"
    else
      @mailer_host = "http://localhost:3000"
    end
  end
end
