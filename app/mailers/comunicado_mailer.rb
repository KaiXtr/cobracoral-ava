class ComunicadoMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comunicado_mailer.novo_comunicado_email.subject
  #
  def novo_comunicado_email
    @comunicado = params[:comunicado]
    @autor_comunicado = Usuario.find(@comunicado.usuario_id).nome_completo
    @link_comunicado = "#{@mailer_host}/comunicados#c" + @comunicado.id.to_s

    usuarios_notificados = Array.new()
    params[:usuarios_list].each do |u|
      preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: u.id)

      if @comunicado.visibilidade_comunicado == "todos_curso" \
        && preferencias_usuario.notificacao_comunicados_coordenacao then
        usuarios_notificados.push(u)
      elsif @comunicado.visibilidade_comunicado == "todas_turmas" \
        && preferencias_usuario.notificacao_comunicados_turma then
        usuarios_notificados.push(u)
      elsif @comunicado.visibilidade_comunicado == "todos_turma" \
        && preferencias_usuario.notificacao_comunicados_turma then
        usuarios_notificados.push(u)
      elsif @comunicado.visibilidade_comunicado == "todos_disciplina" then
        usuarios_notificados.push(u)
      end
    end

    if usuarios_notificados.length > 0 then
      begin
        mail_usuarios = usuarios_notificados.collect(&:email).join(",")
        mail(
            to: mail_usuarios,
            subject: "Novo comunicado de " + @autor_comunicado
            )
        Rails.logger.info "[MAILER] Novo comunicado notificado aos usuários #{mail_usuarios}."
      rescue Errno::ECONNREFUSED
        Rails.logger.error "[MAILER] O cliente de email não está disponível."
      end
    end
  end

  def novo_conteudo_disponivel_email
    @comunicado = params[:comunicado]
    @autor_comunicado = Usuario.find(@comunicado.usuario_id).nome_completo
    @link_conteudo = "#{@mailer_host}/conteudos/#{params[:conteudo_id]}"

    usuarios_notificados = Array.new()
    params[:usuarios_list].each do |u|
      preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: u.id)

      if preferencias_usuario.notificacao_conteudo_liberado then
        usuarios_notificados.push(u)
      end
    end

    if usuarios_notificados.length > 0 then
      begin
        mail_usuarios = usuarios_notificados.collect(&:email).join(",")
        mail(
            to: mail_usuarios,
            subject: "Novo conteúdo disponível de " + params[:nome_disciplina]
            )
        Rails.logger.info "[MAILER] Novo conteúdo disponível notificado aos usuários #{mail_usuarios}."
      rescue Errno::ECONNREFUSED
        Rails.logger.error "[MAILER] O cliente de email não está disponível."
      end
    end
  end
end
