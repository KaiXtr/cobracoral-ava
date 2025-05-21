require "test_helper"

class MensagemMailerTest < ActionMailer::TestCase
  test "nova_mensagem_email" do
    mail = MensagemMailer.nova_mensagem_email
    assert_equal "Nova mensagem email", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
