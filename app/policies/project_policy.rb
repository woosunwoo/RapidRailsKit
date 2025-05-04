class ProjectPolicy < ApplicationPolicy
  def show?
    user_owns_record?
  end

  def update?
    user_owns_record?
  end

  def destroy?
    user_owns_record?
  end

  def create?
    true
  end

  def index?
    true
  end

  private

  def user_owns_record?
    record.user_id == user.id
  end
end
