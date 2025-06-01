require "test_helper"

class AgendamentoMailerTest < ActionMailer::TestCase
  test "agendamento_dia_mailer" do
    mail = AgendamentoMailer.agendamento_dia_email(
      usuarios_list: Usuario.all,
      agendamento: Agendamento.find(1)
    )
    assert_equal "Agendamento dia mailer", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
