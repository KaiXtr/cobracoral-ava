require "application_system_test_case"

class ComunicadosTest < ApplicationSystemTestCase
  setup do
    @comunicado = comunicados(:one)
  end

  test "visiting the index" do
    visit comunicados_url
    assert_selector "h1", text: "Comunicados"
  end

  test "should create comunicado" do
    visit comunicados_url
    click_on "New comunicado"

    fill_in "Conteudo", with: @comunicado.conteudo
    fill_in "Turma", with: @comunicado.turma_id
    fill_in "Usuario", with: @comunicado.usuario_id
    click_on "Create Comunicado"

    assert_text "Comunicado was successfully created"
    click_on "Back"
  end

  test "should update Comunicado" do
    visit comunicado_url(@comunicado)
    click_on "Edit this comunicado", match: :first

    fill_in "Conteudo", with: @comunicado.conteudo
    fill_in "Turma", with: @comunicado.turma_id
    fill_in "Usuario", with: @comunicado.usuario_id
    click_on "Update Comunicado"

    assert_text "Comunicado was successfully updated"
    click_on "Back"
  end

  test "should destroy Comunicado" do
    visit comunicado_url(@comunicado)
    click_on "Destroy this comunicado", match: :first

    assert_text "Comunicado was successfully destroyed"
  end
end
