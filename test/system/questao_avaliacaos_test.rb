require "application_system_test_case"

class QuestaoAvaliacaosTest < ApplicationSystemTestCase
  setup do
    @questao_avaliacao = questao_avaliacaos(:one)
  end

  test "visiting the index" do
    visit questao_avaliacaos_url
    assert_selector "h1", text: "Questao avaliacaos"
  end

  test "should create questao avaliacao" do
    visit questao_avaliacaos_url
    click_on "New questao avaliacao"

    click_on "Create Questao avaliacao"

    assert_text "Questao avaliacao was successfully created"
    click_on "Back"
  end

  test "should update Questao avaliacao" do
    visit questao_avaliacao_url(@questao_avaliacao)
    click_on "Edit this questao avaliacao", match: :first

    click_on "Update Questao avaliacao"

    assert_text "Questao avaliacao was successfully updated"
    click_on "Back"
  end

  test "should destroy Questao avaliacao" do
    visit questao_avaliacao_url(@questao_avaliacao)
    click_on "Destroy this questao avaliacao", match: :first

    assert_text "Questao avaliacao was successfully destroyed"
  end
end
