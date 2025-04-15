class RecipePolicy < ApplicationPolicy
  
  def update?
    record.creator == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end