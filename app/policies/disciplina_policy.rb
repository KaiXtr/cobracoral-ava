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

  def new_conteudo?
    temCargoCoordenador? || permissaoProfessor?
  end

  def show?
    estaNoSemestre?
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
    curso.usuario_id == @usuario.id
  end

  def permissaoProfessor?
    criouConteudo? && temCargoProfessor?
  end

  def criouConteudo?
    disciplina.usuario_id == usuario.id
  end

  def temCargoProfessor?
    cargo = UsuarioCargo.find(usuario.cargo_usuario)
    cargo.id == 2
  end

  def estaNoSemestre?
    if usuario.cargo_usuario > 2 then
      matricula = Matricula.find_by(usuario_id: usuario.id)
      if matricula then
        return @disciplina.semestre == matricula.semestre
      else
        return true
      end
    else
      true
    end
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
