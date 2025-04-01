class ComunicadoPolicy
    # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
    # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
    # In most cases the behavior will be identical, but if updating existing
    # code, beware of possible changes to the ancestors:
    # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
    
    attr_reader :usuario, :comunicado
  
    def initialize(usuario, comunicado)
      @usuario = usuario  
      @comunicado = comunicado
    end
  
    def index?
        true
    end
  
    def new?
        coordenadorCurso? || professorTurma? || representanteTurma?
    end
  
    def show?
        true
    end
    
    def edit?
        criouComunicado?
    end
  
    def create?
        coordenadorCurso? || professorTurma? || representanteTurma?
    end
    
    def update?
        criouComunicado?
    end
    
    def destroy?
        criouComunicado?
    end
  
    private
  
    def coordenadorCurso?
        curso = Curso.find_by(usuario_id: @usuario.id)
        if curso
          true
        else
          false
        end
    end
  
    def professorTurma?
        disciplina = Disciplina.find_by(usuario_id: @usuario.id)
        if (disciplina)
          true
        else
          false
        end
    end
  
    def representanteTurma?
        matricula = Matricula.find_by(
            usuario_id: @usuario.id,
            turma_id: @comunicado.turma_id
        )
        if matricula then
            Usuario.cargo_usuarios[usuario.cargo_usuario] == 3
        else
            false
        end
    end

    def criouComunicado?
        @comunicado.usuario_id == @usuario.id
    end
  
    class Scope < ApplicationPolicy::Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end
end
  