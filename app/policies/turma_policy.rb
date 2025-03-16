class TurmaPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :usuario, :turma

  def initialize(usuario, turma)
    @usuario = usuario  
    @turma = turma
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    coordenadorCriaTurma? || permissaoProfessor? || permissaoRepresentante?
  end

  def new_disciplina?
    temCargoCoordenador?
  end

  def create?
    temCargoCoordenador? || permissaoProfessor? || permissaoRepresentante?
  end
  
  def edit?
    eCoordenadorDoCurso? || permissaoProfessor? || permissaoRepresentante?
  end

  def matricular?
    eCoordenadorDoCurso? || permissaoProfessor? || permissaoRepresentante?
  end
  
  def update?
    eCoordenadorDoCurso? || permissaoProfessor? || permissaoRepresentante?
  end
  
  def destroy?
    eCoordenadorDoCurso?
  end

  private

  def coordenadorCriaTurma?
    true
  end

  def eCoordenadorDoCurso?
    curso = Curso.find(@turma.curso_id)
    curso.usuario_id == @usuario.id
  end

  def temCargoCoordenador?
    curso = Curso.find(@turma.curso_id)
    curso.usuario_id = @usuario.id
  end

  def permissaoProfessor?
    criouConteudo? && temCargoProfessor?
  end

  def criouConteudo?
    #turma.usuario_id == usuario.id
    true
  end

  def temCargoProfessor?
    cargo = UsuarioCargo.find(usuario.usuario_cargo_id)
    cargo.id == 2
  end

  def permissaoRepresentante?
    matriculadoTurma? && temCargoRepresentante?
  end

  def matriculadoTurma?
    matricula = Matricula.find_by(usuario_id: usuario.id)
    if matricula then
      matricula.turma_id == turma.id
    else
      false
    end
  end

  def temCargoRepresentante?
    cargo = UsuarioCargo.find(usuario.usuario_cargo_id)
    cargo.id == 3
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
