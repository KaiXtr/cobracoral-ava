class ConteudoPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :usuario, :conteudo

  def initialize(usuario, conteudo)
    @usuario = usuario  
    @conteudo = conteudo
  end

  def new?
    temCargoCoordenador? || temCargoProfessor?
  end

  def create?
    temCargoCoordenador? || permissaoProfessor?
  end

  def show?
    true
  end
  
  def edit?
    temCargoCoordenador? || permissaoProfessor?
  end
  
  def update?
    temCargoCoordenador? || permissaoProfessor?
  end
  
  def destroy?
    temCargoCoordenador? || permissaoProfessor?
  end

  private

  def temCargoCoordenador?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 1
  end

  def permissaoProfessor?
    criouConteudo? && temCargoProfessor?
  end

  def criouConteudo?
    unidade = UnidadeDisciplina.find(@conteudo.unidade_disciplina_id)
    disciplina = Disciplina.find(unidade.disciplina_id)
    disciplina.usuario_id == usuario.id
  end

  def temCargoProfessor?
    Usuario.cargo_usuarios[usuario.cargo_usuario] == 2
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
