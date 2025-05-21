include ComunicadosHelper
include LeituraConteudosHelper

class ConteudoLiberadoJob < ApplicationJob
  queue_as :default

  def perform(conteudo)
    begin
      comunicado = Comunicado.new()
      comunicado.usuario_id = 9
      comunicado.turma_id = nil
      comunicado.disciplina_id = nil
      comunicado.visibilidade_comunicado = "todos_curso"

      unidade_disciplina = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
      disciplina_conteudo = Disciplina.find_by(id: unidade_disciplina.disciplina_id)
      turma_disciplina = Turma.find_by(id: disciplina_conteudo.turma_id)
      docente_disciplina = Usuario.find_by(id: disciplina_conteudo.usuario_id)

      saudacao = "Boa noite"
      saudacao += " turma #{turma_disciplina.nome_turma}"
      link_conteudo = "<a href=\"/conteudos/#{conteudo.id}\">" +
          "<strong>#{conteudo.nome_conteudo}</strong>" +
        "</a>"

      comunicado_corpo = "#{saudacao}, " +
        "o conteúdo #{link_conteudo} foi liberado " + 
        "por #{docente_disciplina.nome_completo}"

      if conteudo.data_vencimento == nil then
        comunicado_corpo += "."
      else
        comunicado_corpo += " e estará disponível até " +
          "#{conteudo.data_vencimento.strftime("%d/%m/%Y às %H:%M")}."
      end

      comunicado_corpo += "<br>" +
        "<a href=\"/conteudos/#{conteudo.id}\">" +
          "<div id=\"#{conteudo.id}\" class=\"conteudo-button\">" +
            "<div class=\"conteudo-button-info\">" +
              "<h5>#{conteudo.nome_conteudo}</h5>" +
              "<span>#{get_vencimento_restante(conteudo)}</span>" +
            "</div>" +
            "<div class=\"conteudo-button-conclusao\">" +
              "<div class=\"conteudo-button-conclusao-max\"></div>"
            "</div>" +
          "</div>" +
        "</a>"

      comunicado.corpo.body = comunicado_corpo

      comunicado.save
      Rails.logger.info "[JOB] Conteúdo \"#{conteudo.nome_conteudo}\" foi liberado e comunicado para o AVA."

      usuario_comunicado = Usuario.find_by(id: comunicado.usuario_id)
      ComunicadoMailer.with(
        usuarios_list: get_lista_usuarios_notificados(
          usuario_comunicado,
          comunicado),
        comunicado: comunicado).novo_comunicado_email.deliver_later

    rescue SQLite3::BusyException
      Rails.logger.error "[JOB] O conteúdo \"#{conteudo.nome_conteudo}\" não pôde ser liberado: banco de dados está sobrecarregado."
      retry
    end
  end
end
