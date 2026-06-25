# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end


ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular "alternativa_questao", "alternativa_questoes"
  inflect.irregular "assunto_solicitacao", "assunto_solicitacoes"
  inflect.irregular "avaliacao", "avaliacoes"
  inflect.irregular "ementa", "ementas"
  inflect.irregular "mensagem", "mensagens"
  inflect.irregular "questao_avaliacao", "questao_avaliacoes"
  inflect.irregular "reacao_mensagem", "reacao_mensagens"
  inflect.irregular "solicitacao", "solicitacoes"
  inflect.irregular "tentativa_avaliacao", "tentativa_avaliacoes"
end