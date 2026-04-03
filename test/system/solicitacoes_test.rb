require "application_system_test_case"

class SolicitacoesTest < ApplicationSystemTestCase
  setup do
    @solicitacao = solicitacoes(:one)
  end

  test "visiting the index" do
    visit solicitacoes_url
    assert_selector "h1", text: "Solicitacoes"
  end

  test "should create solicitacao" do
    visit solicitacoes_url
    click_on "New solicitacao"

    click_on "Create Solicitacao"

    assert_text "Solicitacao was successfully created"
    click_on "Back"
  end

  test "should update Solicitacao" do
    visit solicitacao_url(@solicitacao)
    click_on "Edit this solicitacao", match: :first

    click_on "Update Solicitacao"

    assert_text "Solicitacao was successfully updated"
    click_on "Back"
  end

  test "should destroy Solicitacao" do
    visit solicitacao_url(@solicitacao)
    click_on "Destroy this solicitacao", match: :first

    assert_text "Solicitacao was successfully destroyed"
  end
end
