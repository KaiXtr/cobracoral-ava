require "test_helper"

class UnidadeDisciplinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unidade_disciplina = unidade_disciplinas(:one)
  end

  test "should get index" do
    get unidade_disciplinas_url
    assert_response :success
  end

  test "should get new" do
    get new_unidade_disciplina_url
    assert_response :success
  end

  test "should create unidade_disciplina" do
    assert_difference("UnidadeDisciplina.count") do
      post unidade_disciplinas_url, params: { unidade_disciplina: { disciplina_id: @unidade_disciplina.disciplina_id, nome_unidade: @unidade_disciplina.nome_unidade } }
    end

    assert_redirected_to unidade_disciplina_url(UnidadeDisciplina.last)
  end

  test "should show unidade_disciplina" do
    get unidade_disciplina_url(@unidade_disciplina)
    assert_response :success
  end

  test "should get edit" do
    get edit_unidade_disciplina_url(@unidade_disciplina)
    assert_response :success
  end

  test "should update unidade_disciplina" do
    patch unidade_disciplina_url(@unidade_disciplina), params: { unidade_disciplina: { disciplina_id: @unidade_disciplina.disciplina_id, nome_unidade: @unidade_disciplina.nome_unidade } }
    assert_redirected_to unidade_disciplina_url(@unidade_disciplina)
  end

  test "should destroy unidade_disciplina" do
    assert_difference("UnidadeDisciplina.count", -1) do
      delete unidade_disciplina_url(@unidade_disciplina)
    end

    assert_redirected_to unidade_disciplinas_url
  end
end
