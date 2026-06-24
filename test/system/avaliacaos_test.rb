require "application_system_test_case"

class AvaliacaosTest < ApplicationSystemTestCase
  setup do
    @avaliacao = avaliacaos(:one)
  end

  test "visiting the index" do
    visit avaliacaos_url
    assert_selector "h1", text: "Avaliacaos"
  end

  test "should create avaliacao" do
    visit avaliacaos_url
    click_on "New avaliacao"

    click_on "Create Avaliacao"

    assert_text "Avaliacao was successfully created"
    click_on "Back"
  end

  test "should update Avaliacao" do
    visit avaliacao_url(@avaliacao)
    click_on "Edit this avaliacao", match: :first

    click_on "Update Avaliacao"

    assert_text "Avaliacao was successfully updated"
    click_on "Back"
  end

  test "should destroy Avaliacao" do
    visit avaliacao_url(@avaliacao)
    click_on "Destroy this avaliacao", match: :first

    assert_text "Avaliacao was successfully destroyed"
  end
end
