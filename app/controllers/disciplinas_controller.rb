class DisciplinasController < ApplicationController
  before_action :set_disciplina, only: %i[ show edit update destroy ]

  # GET /disciplinas or /disciplinas.json
  def index
    @disciplina = Disciplina.new
    @disciplinas = Disciplina.all
    @unidades_disciplina = UnidadeDisciplina.new
    @conteudos = Conteudo.new
    @curso = Curso.new
  end

  # GET /disciplinas/1 or /disciplinas/1.json
  def show
    @estaEditando = false
    @usuario = usuario_autenticado
    @disciplina = Disciplina.find(params[:id])
    @curso = Curso.find_by(id: @disciplina.curso_id)
    @unidades_disciplina = UnidadeDisciplina.where(disciplina_id: @disciplina.id)
    @conteudos = Conteudo.joins(:unidade_disciplina)
      .where(
        unidade_disciplina: { 
          disciplina_id: @disciplina.id
        }
      )
  end

  # GET /disciplinas/new
  def new
    @disciplina = Disciplina.new
  end

  # GET /disciplinas/1/edit
  def edit
    @estaEditando = true
    @usuario = usuario_autenticado
    @disciplina = Disciplina.find(params[:id])

    authorize(@disciplina)

    @unidades_disciplina = UnidadeDisciplina.where(disciplina_id: @disciplina.id)
    @conteudos = Conteudo.joins(:unidade_disciplina)
      .where(
        unidade_disciplina: { 
          disciplina_id: @disciplina.id
        }
      )
  end

  # POST /disciplinas or /disciplinas.json
  def create
    @disciplina = Disciplina.new(disciplina_params)

    respond_to do |format|
      if @disciplina.save
        format.html { redirect_to disciplina_url(@disciplina), notice: "Disciplina was successfully created." }
        format.json { render :show, status: :created, location: @disciplina }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplinas/1 or /disciplinas/1.json
  def update
    respond_to do |format|
      if @disciplina.update(disciplina_params)
        format.html {
            redirect_to disciplina_url(@disciplina),
            notice: "Todas as alterações foram salvas."
          }
        format.json { render :show, status: :ok, location: @disciplina }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1 or /disciplinas/1.json
  def destroy
    @disciplina.destroy

    respond_to do |format|
      format.html { redirect_to disciplinas_url, notice: "Disciplina was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disciplina
      @disciplina = Disciplina.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disciplina_params
      params.require(:disciplina).permit(:nome_disciplina, :semestre)
    end
    
    def isUsuarioEstudante(usuario)
        matricula = Matricula.find_by(usuario_id: usuario.id)
        cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
        cargo.id > 2
    end
end
