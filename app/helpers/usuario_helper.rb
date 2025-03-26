module UsuarioHelper
    def enum_pronomes(pronomes)
        return Usuario.pronomes_usuario_strings[pronomes + '_string']
    end

    def enum_cargo_usuario(usuario)
        cargo = usuario.cargo_usuario

        if usuario.pronomes_usuario == 1 then
            return Usuario.cargo_usuario_feminino_strings[cargo + '_feminino_string']
        else
            return Usuario.cargo_usuario_masculino_strings[cargo + '_masculino_string']
        end
    end

    def isUsuarioDiscente(usuario)
        Usuario.cargo_usuarios[usuario.cargo_usuario] < 3
    end
    
    def turmas_usuario(usuario)
        matriculas = Matricula.where(usuario_id: usuario.id)
        turmas = Array.new

        for matricula in matriculas do
            turmas.push(Turma.find(matricula.turma_id))
        end

        return turmas
    end
end
