module CursosHelper
    def nome_coordenador(curso)
        usuario = Usuario.find(curso.usuario_id)
        usuario.nome_completo
    end
end