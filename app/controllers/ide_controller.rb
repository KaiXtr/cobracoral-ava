class IdeController < ApplicationController
  def index
    @usuario_autenticado = usuario_autenticado
    redirect_to '/entrar' unless @usuario_autenticado
  end
end
