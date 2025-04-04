require "test_helper"

class ComunicadoMailerTest < ActionMailer::TestCase
  test "novo_comunicado_email" do
    mail = ComunicadoMailer.novo_comunicado_email
    assert_equal "Novo comunicado email", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
