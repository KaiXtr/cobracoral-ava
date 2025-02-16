require "test_helper"

class LeituraConteudosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leitura_conteudo = leitura_conteudos(:one)
  end

  test "should get index" do
    get leitura_conteudos_url
    assert_response :success
  end

  test "should get new" do
    get new_leitura_conteudo_url
    assert_response :success
  end

  test "should create leitura_conteudo" do
    assert_difference("LeituraConteudo.count") do
      post leitura_conteudos_url, params: { leitura_conteudo: { conclusao: @leitura_conteudo.conclusao, conteudo_id: @leitura_conteudo.conteudo_id, usuario_id: @leitura_conteudo.usuario_id } }
    end

    assert_redirected_to leitura_conteudo_url(LeituraConteudo.last)
  end

  test "should show leitura_conteudo" do
    get leitura_conteudo_url(@leitura_conteudo)
    assert_response :success
  end

  test "should get edit" do
    get edit_leitura_conteudo_url(@leitura_conteudo)
    assert_response :success
  end

  test "should update leitura_conteudo" do
    patch leitura_conteudo_url(@leitura_conteudo), params: { leitura_conteudo: { conclusao: @leitura_conteudo.conclusao, conteudo_id: @leitura_conteudo.conteudo_id, usuario_id: @leitura_conteudo.usuario_id } }
    assert_redirected_to leitura_conteudo_url(@leitura_conteudo)
  end

  test "should destroy leitura_conteudo" do
    assert_difference("LeituraConteudo.count", -1) do
      delete leitura_conteudo_url(@leitura_conteudo)
    end

    assert_redirected_to leitura_conteudos_url
  end
end
