class ConteudosController < ApplicationController
  before_action :set_conteudo, only: %i[ show edit update destroy ]

  # GET /conteudos or /conteudos.json
  def index
    usuario = usuario_autenticado
    @conteudos = Conteudo.all
  end

  # GET /conteudos/1 or /conteudos/1.json
  def show
    usuario = usuario_autenticado
    conteudo = Conteudo.find(params[:id])
    unidade_do_conteudo = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
    @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)
    @proximoConteudo = Conteudo.joins(:unidade_disciplina).find_by(
      id: conteudo.id + 1,
      unidade_disciplina: { disciplina_id: @disciplina_conteudo.id }
    )
    
    # Iniciar leitura do conteúdo e contabilizar conclusão
    @conclusao_conteudo = 0
    @leitura_conteudo = LeituraConteudo.find_by(
      conteudo_id: conteudo.id,
      usuario_id: usuario.id
    )
    if @leitura_conteudo then
      @conclusao_conteudo = @leitura_conteudo.conclusao
    else
      @leitura_conteudo = LeituraConteudo.new(
        conteudo_id: conteudo.id,
        usuario_id: usuario.id
      )
      @leitura_conteudo.save
    end
  end

  # Atualizar leitura do conteúdo
  def salvar
    usuario = usuario_autenticado
    conteudo = Conteudo.find(params[:id])
    @leitura_conteudo = LeituraConteudo.find_by(
      conteudo_id: conteudo.id,
      usuario_id: usuario.id
    )
    if @leitura_conteudo == nil then
      @leitura_conteudo = LeituraConteudo.new(
        conteudo_id: conteudo.id,
        usuario_id: usuario.id
      )
    end

    # Salvando conclusão da leitura do conteúdo
    @leitura_conteudo.conclusao = 1
    if @leitura_conteudo.save then
      x = 1
    else
      x = 'Falhou'
    end

    # Redirecionando para próximo conteúdo ou de volta à disciplina
    unidade_do_conteudo = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
    @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)
    @proximoConteudo = Conteudo.joins(:unidade_disciplina).find_by(
      id: conteudo.id + 1,
      unidade_disciplina: { disciplina_id: @disciplina_conteudo.id }
    )
    if @proximoConteudo then
      redirect_to conteudo_path(id: @proximoConteudo.id)
    else
      unidade_do_conteudo = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
      @disciplina_conteudo = Disciplina.find_by(id: unidade_do_conteudo.disciplina_id)
      redirect_to disciplina_path(@disciplina_conteudo)
    end
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
