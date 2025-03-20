require "test_helper"

class UsuariosExtControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "nao pode usuario sem email" do
    usuario = Usuario.new
    assert_not usuario.save
  end

  test "nao pode usuario sem senha" do
    usuario = Usuario.new
    usuario.email = "email@exemplo.com"
    assert_not usuario.save
  end
end
