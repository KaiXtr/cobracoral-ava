class ConteudosController < ApplicationController
  before_action :set_conteudo, only: %i[ show edit update destroy ]

  # GET /conteudos or /conteudos.json
  def index
    @conteudos = Conteudo.all
  end

  # GET /conteudos/1 or /conteudos/1.json
  def show
  end

  # GET /conteudos/new
  def new
    @conteudo = Conteudo.new
  end

  # GET /conteudos/1/edit
  def edit
  end

  # POST /conteudos or /conteudos.json
  def create
    @conteudo = Conteudo.new(conteudo_params)

    respond_to do |format|
      if @conteudo.save
        format.html { redirect_to conteudo_url(@conteudo), notice: "Conteudo was successfully created." }
        format.json { render :show, status: :created, location: @conteudo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conteudos/1 or /conteudos/1.json
  def update
    respond_to do |format|
      if @conteudo.update(conteudo_params)
        format.html { redirect_to conteudo_url(@conteudo), notice: "Conteudo was successfully updated." }
        format.json { render :show, status: :ok, location: @conteudo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conteudos/1 or /conteudos/1.json
  def destroy
    @conteudo.destroy

    respond_to do |format|
      format.html { redirect_to conteudos_url, notice: "Conteudo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conteudo
      @conteudo = Conteudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conteudo_params
      params.require(:conteudo).permit(:unidade_disciplina_id, :nome_conteudo)
    end
end
