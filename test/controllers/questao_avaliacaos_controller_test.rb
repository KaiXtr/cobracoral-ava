require "test_helper"

class QuestaoAvaliacaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @questao_avaliacao = questao_avaliacaos(:one)
  end

  test "should get index" do
    get questao_avaliacaos_url
    assert_response :success
  end

  test "should get new" do
    get new_questao_avaliacao_url
    assert_response :success
  end

  test "should create questao_avaliacao" do
    assert_difference("QuestaoAvaliacao.count") do
      post questao_avaliacaos_url, params: { questao_avaliacao: {} }
    end

    assert_redirected_to questao_avaliacao_url(QuestaoAvaliacao.last)
  end

  test "should show questao_avaliacao" do
    get questao_avaliacao_url(@questao_avaliacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_questao_avaliacao_url(@questao_avaliacao)
    assert_response :success
  end

  test "should update questao_avaliacao" do
    patch questao_avaliacao_url(@questao_avaliacao), params: { questao_avaliacao: {} }
    assert_redirected_to questao_avaliacao_url(@questao_avaliacao)
  end

  test "should destroy questao_avaliacao" do
    assert_difference("QuestaoAvaliacao.count", -1) do
      delete questao_avaliacao_url(@questao_avaliacao)
    end

    assert_redirected_to questao_avaliacaos_url
  end
end
