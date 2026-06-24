module MensagensHelper
    def formatar_data_mensagem(data_hora)
        data_agora = DateTime.now
        tempo_mensagem = (data_agora.to_time - data_hora.to_time).to_i

        if (tempo_mensagem > 60*60*24) then
            return 'Ontem'
        else
            return data_hora.strftime("%H:%M")
        end
    end

    def mensagens_novas_usuario(usuario_autenticado, usuario_mensagem)
        mensagens = Mensagem.where(
            remetente_id: usuario_mensagem.id,
            destinatario_id: usuario_autenticado.id
            )
        quant = 0

        mensagens.each do |m|
            quant += ReacaoMensagem.where(
                mensagem_id: m.id, emoji: nil
                ).count()
        end

        if quant > 0 then
            return 'mensagens-novas'
        else
            return ''
        end
    end

    def mensagem_recente_usuario(usuario_autenticado, usuario_mensagem)
        mensagens = Mensagem.where(
            remetente_id: usuario_mensagem.id,
            destinatario_id: usuario_autenticado.id,
            is_privada: true
            ) + 
            Mensagem.where(
                remetente_id: usuario_autenticado.id,
                destinatario_id: usuario_mensagem.id,
                is_privada: true
            )
        
        if mensagens then
            mensagens = mensagens.uniq
            mensagens = mensagens.sort_by{|c| c[:created_at]}
            recente = mensagens.last
            if recente then
                if recente.remetente_id == @usuario_autenticado.id then
                    return recente.corpo.body
                else
                    return recente.corpo.body
                end
            else
                return ''
            end
        else
            return ''
        end
    end

    def get_mensagem_lida(usuario_autenticado, mensagem)
        if usuario_autenticado == nil then
            return ''
        elsif mensagem.destinatario_id == usuario_autenticado.id
            return ''
        else
            lido = ReacaoMensagem.find_by(
                usuario_id: mensagem.destinatario_id,
                mensagem_id: mensagem.id,
                emoji: 'x'
                )
            
            if lido then
                return ' - Lido'
            else
                return ' - Enviado'
            end
        end
    end

    def reacoes_mensagem_quantidade(mensagem, emoji)
        ReacaoMensagem.where(mensagem_id: mensagem.id, emoji: emoji).count()
    end

    def reagir_emoji_mensagem(mensagem, emoji)
		if session[:usuario_id]
			usuario = Usuario.find(session[:usuario_id])
        end
        reacao = ReacaoMensagem.new(
            usuario_id: usuario.id,
            mensagem_id: mensagem.id,
            emoji: emoji
        )
        reacao.save
    end
end
