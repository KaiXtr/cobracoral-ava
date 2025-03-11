class ComunicadosController < ApplicationController
	before_action :redirecionar_nao_logado
  before_action :set_comunicado, only: %i[ show edit update destroy ]

  # GET /comunicados or /comunicados.json
  def index
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new
    @comunicados = Comunicado.all

    # Marcar visualização
    for c in @comunicados do
      if !ReacaoComunicado.find_by(usuario_id: @usuario.id, comunicado_id: c.id) then
        reacao = ReacaoComunicado.new(
            usuario_id: @usuario.id,
            comunicado_id: c.id
        )
        reacao.save
      end
    end
    Rails.logger.info "Acessando todos os comunicados."
  end

  # GET /comunicados/1 or /comunicados/1.json
  def show
    @comunicado = Comunicado.find(params[:id])
    Rails.logger.info "Acessando comunicado " + @comunicado.id.to_s + "."
  end

  # GET /comunicados/new
  def new
    @comunicado = Comunicado.new
    @turmas = Turma.all
		Rails.logger.info "Criando novo comunicado."
  end

  # GET /comunicados/1/edit
  def edit
    @turmas = Turma.all
  end

  # POST /comunicados or /comunicados.json
  def create
    @usuario = usuario_autenticado
    @comunicado = Comunicado.new(comunicado_params)
    @comunicado.usuario_id = @usuario.id

    respond_to do |format|
      if @comunicado.save
        logtxt = "Comunicado adicionado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to comunicado_url(@comunicado), notice: logtxt }
        format.json { render :show, status: :created, location: @comunicado }
      else
        Rails.logger.error "Houve um erro ao criar o comunicado."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comunicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunicados/1 or /comunicados/1.json
  def update
    respond_to do |format|
      if @comunicado.update(comunicado_params)
        logtxt = "Comunicado atualizado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to comunicado_url(@comunicado), notice: logtxt }
        format.json { render :show, status: :ok, location: @comunicado }
      else
        Rails.logger.error "Houve um erro ao atualizar o comunicado."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comunicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comunicados/1 or /comunicados/1.json
  def destroy
    @comunicado.destroy

    respond_to do |format|
			logtxt = "Comunicado deletado com sucesso."
			Rails.logger.info logtxt
      format.html { redirect_to comunicados_url, notice: logtxt }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comunicado
      @comunicado = Comunicado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comunicado_params
      params.require(:comunicado).permit(:usuario_id, :turma_id, :conteudo, imagens: [])
    end
end
