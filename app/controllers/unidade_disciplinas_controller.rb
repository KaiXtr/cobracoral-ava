class UnidadeDisciplinasController < ApplicationController
  before_action :set_unidade_disciplina, only: %i[ show edit update destroy ]

  # GET /unidade_disciplinas or /unidade_disciplinas.json
  def index
    @unidade_disciplinas = UnidadeDisciplina.all
  end

  # GET /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def show
  end

  # GET /unidade_disciplinas/new
  def new
    @unidade_disciplina = UnidadeDisciplina.new
  end

  # GET /unidade_disciplinas/1/edit
  def edit
  end

  # POST /unidade_disciplinas or /unidade_disciplinas.json
  def create
    @unidade_disciplina = UnidadeDisciplina.new(unidade_disciplina_params)

    respond_to do |format|
      if @unidade_disciplina.save
        format.html { redirect_to unidade_disciplina_url(@unidade_disciplina), notice: "Unidade disciplina was successfully created." }
        format.json { render :show, status: :created, location: @unidade_disciplina }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unidade_disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def update
    respond_to do |format|
      if @unidade_disciplina.update(unidade_disciplina_params)
        format.html { redirect_to unidade_disciplina_url(@unidade_disciplina), notice: "Unidade disciplina was successfully updated." }
        format.json { render :show, status: :ok, location: @unidade_disciplina }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unidade_disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidade_disciplinas/1 or /unidade_disciplinas/1.json
  def destroy
    @unidade_disciplina.destroy

    respond_to do |format|
      format.html { redirect_to unidade_disciplinas_url, notice: "Unidade disciplina was successfully destroyed." }
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
