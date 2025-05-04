# frozen_string_literal: true
require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  subject { described_class.new(user, project) }

  it "permits owner to show" do
    expect(subject).to permit_action(:show)
  end

  it "denies non-owner from show" do
    subject = described_class.new(create(:user), project)
    expect(subject).to forbid_action(:show)
  end
end
