class UsuariosController < ApplicationController
	before_action :redirecionar_nao_logado

    def index    
        @usuarios = Usuario.all_except(@usuario_autenticado)
        Rails.logger.info "Exibindo todos(as) os(as) usuários(as)."
    end

    def edit
        @usuario = usuario_autenticado
    end
  
    def create
        @usuario = Usuario.create(nome_completo: params["usuario"]["nome_completo"])
        Rails.logger.info "Criado cadastro para novo(a) usuário(a)."
    end

    def show
		@usuario = usuario_autenticado
        @link_lattes = "https://lattes.cnpq.br/" + @usuario.lattes_id.to_s
        @link_orcid = "https://orcid.org/" + @usuario.orcid_id.to_s
        Rails.logger.info "Acessando perfil do(a) usuário(a) " + @usuario.nome_completo + "."
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
                logtxt = "Usuário(a) " + usuario.nome_completo + " foi matriculado(a) com sucesso na turma " + turma.nome_turma + "."
                Rails.logger.info logtxt
                format.html {
                  redirect_to "/turmas/" + turma.id.to_s + "/matricular",
                  notice: logtxt
                }
                format.json { render :show, status: :created, location: turma }
            else
                logtxt = "Houve um erro ao matricular o(a) usuário(a) " + usuario.nome_completo + " na turma " + turma.nome_turma + "."
                Rails.logger.error logtxt
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: turma.errors, status: :unprocessable_entity }
            end
        end
    end

    def desmatricular
        usuario = Usuario.find(params[:usuario_id])
        turma = Turma.find(params[:turma_id])
        matricula = Matricula.find_by(usuario_id: usuario.id, turma_id: turma.id)

        respond_to do |format|
            if matricula.destroy
                logtxt = "Matricula do(a) usuário(a) " + usuario.nome_completo + " na turma " + turma.nome_turma + " foi removida com sucesso."
                Rails.logger.info logtxt
                format.html {
                  redirect_to "/turmas/" + turma.id.to_s + "/matricular",
                  notice: logtxt
                }
                format.json { render :show, status: :created, location: turma }
            else
                logtxt = "Houve um erro ao remover matricula do(a) usuário(a) " + usuario.nome_completo + " na turma " + turma.nome_turma + "."
                Rails.logger.error logtxt
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: turma.errors, status: :unprocessable_entity }
            end
        end
    end

    def perfil
        @usuario = usuario_autenticado
        Rails.logger.info "Exibindo perfil do(a) usuário(a) " + @usuario.nome_completo + "."
        redirect_to usuario_path(@usuario)
    end

    def caixa
        @usuario = usuario_autenticado
        Rails.logger.info "Redirecionando para caixa de entrada de " + @usuario.email + "."
        redirect_to "https://mail.google.com/mail", allow_other_host: true
    end
end
