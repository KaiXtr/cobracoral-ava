class CursoPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :usuario, :curso

  def initialize(usuario, curso)
    @usuario = usuario  
    @curso = curso
  end

  def index?
    naoEstudante? || temCargoProfessor?
  end

  def new?
    naoEstudante?
  end

  def create?
    naoEstudante?
  end
  
  def edit?
    eCoordenadorDoCurso?
  end

  def index_turmas?
    true
  end

  def index_disciplinas?
    eCoordenadorDoCurso? || temCargoProfessor?
  end

  def adicionar_turma?
    eCoordenadorDoCurso? || temCargoProfessor? || permissaoRepresentante?
  end

  def adicionar_disciplina?
    eCoordenadorDoCurso?
  end

  def show?
    true
  end
  
  def update?
    eCoordenadorDoCurso?
  end
  
  def destroy?
    eCoordenadorDoCurso?
  end

  def temCargoProfessor?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 2
  end

  private

  def naoEstudante?
    if usuario then
      matricula = Matricula.find_by(usuario_id: usuario.id)
      if matricula then
        false
      else
        true
      end
    else
      false
    end
  end

  def eCoordenadorDoCurso?
    @curso.usuario_id == @usuario.id
  end

  def criouConteudo?
    disciplina.usuario_id == usuario.id
  end

  def permissaoRepresentante?
    matriculadoTurma? && temCargoRepresentante?
  end

  def matriculadoTurma?
    matricula = Matricula.find_by(usuario_id: usuario.id)
    matricula.turma_id == turma.id
  end

  def temCargoRepresentante?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 3
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
