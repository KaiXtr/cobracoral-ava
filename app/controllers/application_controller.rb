#helper_method: current_user

def usuario_atual
	if session[:usuario_id]
		@current_user = Usuario.find(session[:usuario_id])
	end
end

def logar(usuario)
	session[:usuario_id] = usuario.id
	@current_user = usuario
	redirect_to root_path
end

def logado?
	!current_user.nil?
end

def logout
	session.delete(:usuario_id)
	@current_user = nil
end


class ApplicationController < ActionController::Base
end
