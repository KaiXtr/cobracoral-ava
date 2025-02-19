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

  def new?
    temCargoCoordenador?
  end

  def create?
    temCargoCoordenador?
  end
  
  def edit?
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

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
