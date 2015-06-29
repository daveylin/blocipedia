class WikiPolicy < ApplicationPolicy
  def index?
    true
  end 
  
  def update?
    user.present?
  end
  
  def create?
    user.present?
  end
  
  def destroy?
    (user.present? && user.admin?)
  end
  
  def show?
    user.present?
  end
end