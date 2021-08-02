# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReactionManager::AddReactionService do
  let(:result) { described_class.call(current_user, record, value) }

  let(:current_user) { create(:user) }
  let(:record) { create(:post) }

  context "when reaction is invalid" do
    let(:value) { nil }

    it "result not successful" do
      expect(result.success).eql? false
    end
  end
end
