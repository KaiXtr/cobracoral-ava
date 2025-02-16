require "application_system_test_case"

class LeituraConteudosTest < ApplicationSystemTestCase
  setup do
    @leitura_conteudo = leitura_conteudos(:one)
  end

  test "visiting the index" do
    visit leitura_conteudos_url
    assert_selector "h1", text: "Leitura conteudos"
  end

  test "should create leitura conteudo" do
    visit leitura_conteudos_url
    click_on "New leitura conteudo"

    fill_in "Conclusao", with: @leitura_conteudo.conclusao
    fill_in "Conteudo", with: @leitura_conteudo.conteudo_id
    fill_in "Usuario", with: @leitura_conteudo.usuario_id
    click_on "Create Leitura conteudo"

    assert_text "Leitura conteudo was successfully created"
    click_on "Back"
  end

  test "should update Leitura conteudo" do
    visit leitura_conteudo_url(@leitura_conteudo)
    click_on "Edit this leitura conteudo", match: :first

    fill_in "Conclusao", with: @leitura_conteudo.conclusao
    fill_in "Conteudo", with: @leitura_conteudo.conteudo_id
    fill_in "Usuario", with: @leitura_conteudo.usuario_id
    click_on "Update Leitura conteudo"

    assert_text "Leitura conteudo was successfully updated"
    click_on "Back"
  end

  test "should destroy Leitura conteudo" do
    visit leitura_conteudo_url(@leitura_conteudo)
    click_on "Destroy this leitura conteudo", match: :first

    assert_text "Leitura conteudo was successfully destroyed"
  end
end
