require "test_helper"

class ConteudosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario_autenticado = Usuario.create(
      email: "exemplo@exemplo.com",
      password_digest: BCrypt::Password.create("exemplo")
    )
    @conteudo = Conteudo.new
    @conteudo.nome_conteudo = "Nome do conteúdo"
    @conteudo.unidade_disciplina_id = 1
    @conteudo.save
  end

  '''test "should get index" do
    get conteudos_url
    assert_response :success
  end

  test "should get new" do
    get new_conteudo_url
    assert_response :success
  end

  test "should create conteudo" do
    assert_difference("Conteudo.count") do
      post conteudos_url, params: {
        conteudo: {
          nome_conteudo: "Nome do conteúdo",
          unidade_disciplina_id: 1
        }
      }
    end

    assert_redirected_to conteudo_url(Conteudo.last)
  end

  test "should show conteudo" do
    get conteudo_url(@conteudo)
    assert_response :success
  end

  test "should get edit" do
    get edit_conteudo_url(@conteudo)
    assert_response :success
  end

  test "should update conteudo" do
    patch conteudo_url(@conteudo), params: {
        conteudo: {
          nome_conteudo: "Nome do conteúdo",
          unidade_disciplina_id: 1
        }
    }
    assert_redirected_to conteudo_url(@conteudo)
  end

  test "should destroy conteudo" do
    assert_difference("Conteudo.count", -1) do
      delete conteudo_url(@conteudo)
    end

    assert_redirected_to conteudos_url
  end'''
end
