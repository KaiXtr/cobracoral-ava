class UnidadeDisciplinasController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_unidade_disciplina, only: %i[ show edit update destroy ]

  # GET /unidade_disciplinas or /unidade_disciplinas.json
  def index
    @unidade_disciplinas = UnidadeDisciplina.all
    @conteudos = Conteudo.new
    Rails.logger.info "Acessando todas as unidades de disciplina."
  end

  # GET /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def show
    @unidade_disciplina = UnidadeDisciplina.find(params[:id])
    @conteudos = Conteudo.find(params[:id])
    Rails.logger.info "Acessando unidade de disciplina " + @unidade_disciplina.nome_unidade + " e seus conteúdos."
  end

  # GET /unidade_disciplinas/new
  def new
    @unidade_disciplina = UnidadeDisciplina.new
    Rails.logger.info "Adicionando nova unidade de disciplina."
  end

  # POST /unidade_disciplinas or /unidade_disciplinas.json
  def create
    @unidade_disciplina = UnidadeDisciplina.new(unidade_disciplina_params)
    disciplina = Disciplina.find(@unidade_disciplina.disciplina_id)

    respond_to do |format|
      if @unidade_disciplina.save
        logtxt = "Unidade " + @unidade_disciplina.nome_unidade + " da disciplina " + disciplina.nome_disciplina + " criada com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to unidade_disciplina_url(@unidade_disciplina), notice: logtxt }
        format.json { render :show, status: :created, location: @unidade_disciplina }
      else
			  Rails.logger.error "Houve um erro ao criar a unidade" + @unidade_disciplina.nome_unidade + " da disciplina " + disciplina.nome_disciplina + "."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unidade_disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def update
    respond_to do |format|
      if @unidade_disciplina.update(unidade_disciplina_params)
        logtxt = "Unidade " + @unidade_disciplina.nome_unidade + " da disciplina " + disciplina.nome_disciplina + " atualizada com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to unidade_disciplina_url(@unidade_disciplina), notice: logtxt }
        format.json { render :show, status: :ok, location: @unidade_disciplina }
      else
			  Rails.logger.error "Houve um erro ao atualizar a unidade" + @unidade_disciplina.nome_unidade + " da disciplina " + disciplina.nome_disciplina + "."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unidade_disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def destroy
    @unidade_disciplina.destroy

    respond_to do |format|
      logtxt = "Unidade " + @unidade_disciplina.nome_unidade + " da disciplina " + disciplina.nome_disciplina + " deletada com sucesso."
      Rails.logger.info logtxt
      format.html { redirect_to unidade_disciplinas_url, notice: logtxt }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidade_disciplina
      @unidade_disciplina = UnidadeDisciplina.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unidade_disciplina_params
      params.require(:unidade_disciplina).permit(:disciplina_id, :nome_unidade)
    end
end
