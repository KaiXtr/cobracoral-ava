class DisciplinaPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  
  attr_reader :usuario, :disciplina

  def initialize(usuario, disciplina)
    @usuario = usuario  
    @disciplina = disciplina
  end

  def index?
    disciplinaEstaEmCursoCoordenadoPor?
  end

  def new?
    index?
  end

  def show?
    true
  end
  
  def edit?
    temCargoCoordenador? || permissaoProfessor?
  end

  def create?
    temCargoCoordenador?
  end
  
  def update?
    temCargoCoordenador? || permissaoProfessor?
  end
  
  def destroy?
    temCargoCoordenador?
  end

  private

  def disciplinaEstaEmCursoCoordenadoPor?
    disciplinas = Disciplina.all
    temCoordenador = false

    for disciplina in disciplinas do
      curso_disciplina = Curso.find(disciplina.curso_id)
      if !temCoordenador then
        temCoordenador = curso_disciplina.usuario_id == @usuario.id
      end
    end

    return temCoordenador
  end

  def temCargoCoordenador?
    curso = Curso.find(@disciplina.curso_id)
    curso.usuario_id = @usuario.id
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

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
