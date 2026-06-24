module SolicitacoesHelper
  def get_assunto(id)
    assunto = AssuntoSolicitacao.find(id)
    return assunto.enum_assunto.capitalize
  end

  def get_code 
    caracteres = ('A'..'Z').to_a + ('0'..'9').to_a
    codigo = Array.new(6) { caracteres.sample }.join
    codigo
  end

  def get_status (situacao)
    if situacao == "Deferida" then
      return "#7DFF56"
    elsif situacao == "Indeferida" then
      return "#FF0000"
    else
      return "#FFCC00"
    end 
  end
end
