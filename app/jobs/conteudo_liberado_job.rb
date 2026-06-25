include ConteudosHelper
include ComunicadosHelper
include LeituraConteudosHelper

class ConteudoLiberadoJob < ApplicationJob
  queue_as :default

  def perform(conteudo)
    liberacao = (conteudo.data_liberacao.to_date - DateTime.now.to_date).to_i
    vencimento = (conteudo.data_vencimento.to_date - DateTime.now.to_date).to_i
    if liberacao <= 0 && vencimento > 0 && conteudo.data_liberacao.to_date == Date.now then
      begin
        unidade_disciplina = UnidadeDisciplina.find_by(id: conteudo.unidade_disciplina_id)
        disciplina_conteudo = Disciplina.find_by(id: unidade_disciplina.disciplina_id)
        turma_disciplina = Turma.find_by(id: disciplina_conteudo.turma_id)
        docente_disciplina = Usuario.find_by(id: disciplina_conteudo.usuario_id)

        comunicado = Comunicado.new()
        comunicado.usuario_id = disciplina_conteudo.usuario_id
        comunicado.turma_id = disciplina_conteudo.turma_id
        comunicado.disciplina_id = disciplina_conteudo.id
        comunicado.visibilidade_comunicado = "todos_disciplina"

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
        ementa_disciplina = Ementa.find_by(id: disciplina_conteudo.ementa_id)
        ComunicadoMailer.with(
          usuarios_list: get_lista_usuarios_notificados(
            usuario_comunicado,
            comunicado),
          comunicado: comunicado,
          nome_disciplina: ementa_disciplina.nome_ementa,
          conteudo_id: conteudo.id).novo_conteudo_disponivel_email.deliver_now

      rescue SQLite3::BusyException
        Rails.logger.error "[JOB] O conteúdo \"#{conteudo.nome_conteudo}\" não pôde ser liberado: banco de dados está sobrecarregado."
        retry
      end
    else
      Rails.logger.info "[JOB] O conteúdo \"#{conteudo.nome_conteudo}\" ainda não está disponível."
    end
  end
end
