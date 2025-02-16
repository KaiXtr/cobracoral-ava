class LeituraConteudosController < ApplicationController
  before_action :set_leitura_conteudo, only: %i[ show edit update destroy ]

  # GET /leitura_conteudos or /leitura_conteudos.json
  def index
    @estaNoKanban = true
    @usuario = usuario_autenticado

    @tarefasFazendo = Conteudo.joins(:leitura_conteudo).where(
      leitura_conteudo: { usuario_id: @usuario.id, conclusao: 0 })
    @tarefasFeitas = Conteudo.joins(:leitura_conteudo).where(
      leitura_conteudo: { usuario_id: @usuario.id, conclusao: 1 })
    @tarefasAFazer = Conteudo.where.not(id: Conteudo.joins(:leitura_conteudo).all)
  end

  # GET /leitura_conteudos/1 or /leitura_conteudos/1.json
  def show
  end

  # GET /leitura_conteudos/new
  def new
    @leitura_conteudo = LeituraConteudo.new
  end

  # GET /leitura_conteudos/1/edit
  def edit
  end

  # POST /leitura_conteudos or /leitura_conteudos.json
  def create
    @leitura_conteudo = LeituraConteudo.new(leitura_conteudo_params)

    respond_to do |format|
      if @leitura_conteudo.save
        format.html { redirect_to leitura_conteudo_url(@leitura_conteudo), notice: "Leitura conteudo was successfully created." }
        format.json { render :show, status: :created, location: @leitura_conteudo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leitura_conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leitura_conteudos/1 or /leitura_conteudos/1.json
  def update
    respond_to do |format|
      if @leitura_conteudo.update(leitura_conteudo_params)
        format.html { redirect_to leitura_conteudo_url(@leitura_conteudo), notice: "Leitura conteudo was successfully updated." }
        format.json { render :show, status: :ok, location: @leitura_conteudo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leitura_conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leitura_conteudos/1 or /leitura_conteudos/1.json
  def destroy
    @leitura_conteudo.destroy

    respond_to do |format|
      format.html { redirect_to leitura_conteudos_url, notice: "Leitura conteudo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leitura_conteudo
      @leitura_conteudo = LeituraConteudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leitura_conteudo_params
      params.require(:leitura_conteudo).permit(:conteudo_id, :usuario_id, :conclusao)
    end
end
