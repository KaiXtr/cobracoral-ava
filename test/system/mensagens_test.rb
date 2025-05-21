require "application_system_test_case"

class MensagensTest < ApplicationSystemTestCase
  setup do
    @mensagem = mensagens(:one)
  end

  test "visiting the index" do
    visit mensagens_url
    assert_selector "h1", text: "Mensagens"
  end

  test "should create mensagem" do
    visit mensagens_url
    click_on "New mensagem"

    fill_in "Destinatario", with: @mensagem.destinatario_id
    fill_in "Remetente", with: @mensagem.remetente_id
    click_on "Create Mensagem"

    assert_text "Mensagem was successfully created"
    click_on "Back"
  end

  test "should update Mensagem" do
    visit mensagem_url(@mensagem)
    click_on "Edit this mensagem", match: :first

    fill_in "Destinatario", with: @mensagem.destinatario_id
    fill_in "Remetente", with: @mensagem.remetente_id
    click_on "Update Mensagem"

    assert_text "Mensagem was successfully updated"
    click_on "Back"
  end

  test "should destroy Mensagem" do
    visit mensagem_url(@mensagem)
    click_on "Destroy this mensagem", match: :first

    assert_text "Mensagem was successfully destroyed"
  end
end
