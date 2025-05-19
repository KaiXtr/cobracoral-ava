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
