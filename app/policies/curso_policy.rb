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
    temCargoCoordenador?
  end

  def new?
    temCargoCoordenador?
  end

  def create?
    temCargoCoordenador?
  end
  
  def edit?
    temCargoCoordenador?
  end

  def index_turmas?
    true
  end

  def index_disciplinas?
    temCargoCoordenador? || permissaoProfessor?
  end

  def adicionar_turma?
    temCargoCoordenador? || permissaoProfessor? || permissaoRepresentante?
  end

  def adicionar_disciplina?
    temCargoCoordenador?
  end

  def show?
    true
  end
  
  def update?
    temCargoCoordenador?
  end
  
  def destroy?
    temCargoCoordenador?
  end

  private

  def temCargoCoordenador?
    @curso.usuario_id = @usuario.id
  end

  def permissaoProfessor?
    criouConteudo? && temCargoProfessor?
  end

  def criouConteudo?
    disciplina.usuario_id == usuario.id
  end

  def temCargoProfessor?
    matricula = Matricula.find_by(usuario_id: usuario.id)
    cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
    cargo.id == 2
  end

  def permissaoRepresentante?
    matriculadoTurma? && temCargoRepresentante?
  end

  def matriculadoTurma?
    matricula = Matricula.find_by(usuario_id: usuario.id)
    matricula.turma_id == turma.id
  end

  def temCargoRepresentante?
    matricula = Matricula.find_by(usuario_id: usuario.id)
    cargo = MatriculaCargo.find(matricula.matricula_cargo_id)
    cargo.id == 3
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
