require "application_system_test_case"

class UnidadeDisciplinasTest < ApplicationSystemTestCase
  setup do
    @unidade_disciplina = unidade_disciplinas(:one)
  end

  test "visiting the index" do
    visit unidade_disciplinas_url
    assert_selector "h1", text: "Unidade disciplinas"
  end

  test "should create unidade disciplina" do
    visit unidade_disciplinas_url
    click_on "New unidade disciplina"

    fill_in "Disciplina", with: @unidade_disciplina.disciplina_id
    fill_in "Nome unidade", with: @unidade_disciplina.nome_unidade
    click_on "Create Unidade disciplina"

    assert_text "Unidade disciplina was successfully created"
    click_on "Back"
  end

  test "should update Unidade disciplina" do
    visit unidade_disciplina_url(@unidade_disciplina)
    click_on "Edit this unidade disciplina", match: :first

    fill_in "Disciplina", with: @unidade_disciplina.disciplina_id
    fill_in "Nome unidade", with: @unidade_disciplina.nome_unidade
    click_on "Update Unidade disciplina"

    assert_text "Unidade disciplina was successfully updated"
    click_on "Back"
  end

  test "should destroy Unidade disciplina" do
    visit unidade_disciplina_url(@unidade_disciplina)
    click_on "Destroy this unidade disciplina", match: :first

    assert_text "Unidade disciplina was successfully destroyed"
  end
end
