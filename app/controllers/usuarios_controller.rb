class UsuariosController < ApplicationController
    def index
        # Redirecionar usuário não autenticado
        @usuario_autenticado = usuario_autenticado
        redirect_to '/entrar' unless @usuario_autenticado
        
        @usuarios = Usuario.all_except(@usuario_autenticado)
    end
  
    def create
        @usuario = Usuario.create(nome_completo: params["usuario"]["nome_completo"])
    end

    def show
        @usuario = Usuario.find(params[:id])
        @link_lattes = "https://lattes.cnpq.br/" + @usuario.lattes_id.to_s
        @link_orcid = "https://orcid.org/" + @usuario.orcid_id.to_s
    end

    def matricular
        usuario = Usuario.find(params[:usuario_id])
        turma = Turma.find(params[:turma_id])
        matricula_cargo = MatriculaCargo.find(6)

        matricula = Matricula.new
        matricula.usuario_id = usuario.id
        matricula.turma_id = turma.id
        matricula.matricula_cargo_id = matricula_cargo.id

		respond_to do |format|
		  if matricula.save
			format.html {
				redirect_to turma_url(turma),
				notice: "O estudante " + usuario.nome_completo + " foi matriculado com sucesso na turma " + turma.nome_turma + "."
			}
			format.json { render :show, status: :created, location: turma }
		  else
			format.html { render :new, status: :unprocessable_entity }
			format.json { render json: turma.errors, status: :unprocessable_entity }
		  end
		end
    end

    def perfil
        @usuario = usuario_autenticado
        redirect_to usuario_path(@usuario)
    end

    def caixa
        redirect_to "https://mail.google.com/mail"
    end
end
