class SolicitacoesController < ApplicationController
  before_action :set_solicitacao, only: %i[ show edit update destroy ]

  # GET /solicitacoes or /solicitacoes.json
  def index
    @solicitacoes = Solicitacao.all
  end

  # GET /solicitacoes/1 or /solicitacoes/1.json
  def show
    id = params[:id]
    @solicitacao = Solicitacao.find(id)
    @usuario = get_usuario_autenticado
  end

  # GET /solicitacoes/new
  def new
    @usuario = get_usuario_autenticado
    @assunto_solicitacao = AssuntoSolicitacao.all
    @solicitacao = Solicitacao.new
    @solicitacao_denuncia = SolicitacaoDenuncium.new
  end

  # GET /solicitacoes/1/edit
  def edit
  end

  # POST /solicitacoes or /solicitacoes.json
  def create
    valores = params[:solicitacao_denuncium]
    usuario = get_usuario_autenticado
  
    @solicitacao = Solicitacao.new(situacao: "Solicitada", observacoes: valores[:observacoes], usuario_id: usuario.id, assunto_solicitacoes_id: valores[:assunto_solicitacao])
    @solicitacao_denuncia = SolicitacaoDenuncium.new(solicitacoes_id: Solicitacaoclear.count + 1, nome_envolvido: valores[:nome_envolvido], data_ocorrido: valores[:data], tipo_denuncia: valores[:tipo], descricao: valores[:descricao])

    respond_to do |format|
      if @solicitacao.save && @solicitacao_denuncia.save
        format.html { redirect_to solicitacao_url(@solicitacao), notice: "Solicitacao was successfully created." }
        format.json { render :show, status: :created, location: @solicitacao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @solicitacao.errors, status: :unprocessable_entity }
      end
    end
    

  end

  # PATCH/PUT /solicitacoes/1 or /solicitacoes/1.json
  def update
    respond_to do |format|
      if @solicitacao.update(solicitacao_params)
        format.html { redirect_to solicitacao_url(@solicitacao), notice: "Solicitacao was successfully updated." }
        format.json { render :show, status: :ok, location: @solicitacao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @solicitacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solicitacoes/1 or /solicitacoes/1.json
  def destroy
    @solicitacao.destroy!

    respond_to do |format|
      format.html { redirect_to solicitacoes_url, notice: "Solicitacao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solicitacao
      @solicitacao = Solicitacao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def solicitacao_params
      params.fetch(:solicitacao, {})
    end
end
