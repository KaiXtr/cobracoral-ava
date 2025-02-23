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

    Rails.logger.info "Acessando tarefas do(a) usuário(a) " + @usuario.nome_completo + "."
  end
  
  # POST /leitura_conteudos or /leitura_conteudos.json
  def create
    @leitura_conteudo = LeituraConteudo.new(leitura_conteudo_params)
    conteudo = Conteudo.find(@leitura_conteudo.conteudo_id)

    respond_to do |format|
      if @leitura_conteudo.save
        logtxt = "Progresso de leitura do conteúdo " + conteudo.nome_conteudo + " adicionado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to leitura_conteudo_url(@leitura_conteudo), notice: logtxt }
        format.json { render :show, status: :created, location: @leitura_conteudo }
      else
			  Rails.logger.error "Houve um erro ao criar o progresso de leitura do conteudo " + @conteudo.nome_conteudo + "."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leitura_conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leitura_conteudos/1 or /leitura_conteudos/1.json
  def update
    respond_to do |format|
      if @leitura_conteudo.update(leitura_conteudo_params)
        logtxt = "Progresso de leitura do conteúdo " + conteudo.nome_conteudo + " atualizado com sucesso."
        Rails.logger.info logtxt
        format.html { redirect_to leitura_conteudo_url(@leitura_conteudo), notice: logtxt }
        format.json { render :show, status: :ok, location: @leitura_conteudo }
      else
			  Rails.logger.error "Houve um erro ao atualizar o progresso de leitura do conteudo " + @conteudo.nome_conteudo + "."
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leitura_conteudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leitura_conteudos/1 or /leitura_conteudos/1.json
  def destroy
    @leitura_conteudo.destroy

    respond_to do |format|
      logtxt = "Progresso de leitura do conteúdo " + @conteudo.nome_conteudo + " deletado com sucesso."
			Rails.logger.error logtxt
      format.html { redirect_to leitura_conteudos_url, notice: logtxt }
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
