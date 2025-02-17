module UsuarioHelper
    def pronomes_usuario(usuario)
        return PronomesUsuario.find(usuario.pronomes_usuarios_id)
    end
    def turmas_usuario(usuario)
        matriculas = Matricula.where(usuario_id: usuario.id)
        turmas = Array.new

        for matricula in matriculas do
            turmas.push(Turma.find(matricula.turma_id))
        end

        return turmas
    end
    def cargo_usuario(usuario)
        matricula = Matricula.find_by(usuario_id: usuario.id)
        cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
        pronomes = PronomesUsuario.find(usuario.pronomes_usuarios_id)

        if pronomes.id == 1 then
            return cargo.enumCargoFeminino
        else
            return cargo.enumCargoMasculino
        end
    end
end
