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

  def adicionar_disciplina?
    eCoordenadorDoCurso?
  end

  def create?
    coordenadorCriaTurma? || permissaoProfessor? || permissaoRepresentante?
  end
  
  def edit?
    eCoordenadorDoCurso? || permissaoProfessor?
  end

  def matricular?
    eCoordenadorDoCurso? || permissaoProfessor?
  end
  
  def update?
    eCoordenadorDoCurso? || permissaoProfessor?
  end
  
  def destroy?
    eCoordenadorDoCurso?
  end

  private

  def coordenadorCriaTurma?
    curso = Curso.find_by(usuario_id: @usuario.id)
    if curso then
      curso.usuario_id == @usuario.id
    else
      false
    end
  end

  def eCoordenadorDoCurso?
    curso = Curso.find(@turma.curso_id)
    curso.usuario_id == @usuario.id
  end

  def temCargoCoordenador?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 1
  end

  def permissaoProfessor?
   temCargoProfessor? &&  lecionaNaTurma?
  end

  def criouConteudo?
    #turma.usuario_id == usuario.id
    true
  end

  def lecionaNaTurma?
    disciplinas = Disciplina.where(usuario_id: usuario.id)
    if (disciplinas) then
      leciona = false
      for d in disciplinas do
        t = Turma.find(d.turma_id)
        if (t && t.id == turma.id) then
          leciona = true
        end
      end
      return leciona
    else
      return false
    end
  end

  def temCargoProfessor?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 2
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
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 3
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
