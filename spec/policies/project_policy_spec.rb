# ./spec/policies/project_policy_spec.rb
require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  subject { described_class }

  permissions :show?, :update?, :destroy? do
    it "grants access if user owns the project" do
      expect(subject).to permit(user, project)
    end

    it "denies access if user doesn't own the project" do
      other_user = create(:user)
      expect(subject).not_to permit(other_user, project)
    end
  end
end
