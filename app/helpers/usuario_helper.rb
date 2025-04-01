module UsuarioHelper
    def enum_pronomes(pronomes)
        hash = Usuario.pronomes_usuario_strings.transform_keys(&:to_s)
        return hash[pronomes + '_string']
    end

    def enum_cargo_usuario(usuario)
        hashFeminino = Usuario.cargo_usuario_feminino_strings.transform_keys(&:to_s)
        hashMasculino = Usuario.cargo_usuario_masculino_strings.transform_keys(&:to_s)
        cargo = usuario.cargo_usuario

        if usuario.pronomes_usuario == 1 then
            return hashFeminino[cargo + '_feminino_string']
        else
            return hashMasculino[cargo + '_masculino_string']
        end
    end

    def select_pronomes
        Usuario.pronomes_usuarios.map{ |t| [
            enum_pronomes(t[0]), t[0], {
                'pronome-id' => t[0]
            }
        ]}
    end

    def select_cargo_usuario(usuario)
        Usuario.cargo_usuarios.map{ |t| [
            enum_cargo_usuario(usuario), t[0], {
                'cargo-id' => t[0]
            }
        ]}
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
