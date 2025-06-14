require "test_helper"

class SolicitacoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solicitacao = solicitacoes(:one)
  end

  test "should get index" do
    get solicitacoes_url
    assert_response :success
  end

  test "should get new" do
    get new_solicitacao_url
    assert_response :success
  end

  test "should create solicitacao" do
    assert_difference("Solicitacao.count") do
      post solicitacoes_url, params: { solicitacao: {} }
    end

    assert_redirected_to solicitacao_url(Solicitacao.last)
  end

  test "should show solicitacao" do
    get solicitacao_url(@solicitacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_solicitacao_url(@solicitacao)
    assert_response :success
  end

  test "should update solicitacao" do
    patch solicitacao_url(@solicitacao), params: { solicitacao: {} }
    assert_redirected_to solicitacao_url(@solicitacao)
  end

  test "should destroy solicitacao" do
    assert_difference("Solicitacao.count", -1) do
      delete solicitacao_url(@solicitacao)
    end

    assert_redirected_to solicitacoes_url
  end
end
