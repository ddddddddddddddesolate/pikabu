# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentManager::AddCommentToPostService do
  let(:result) { described_class.call(current_user, post, params) }

  let(:current_user) { create(:user) }
  let(:post) { create(:post) }

  context "when params is invalid" do
    let(:params) do
      {
        text: nil
      }
    end

    it "result not successful" do
      expect(result.success).eql? false
    end
  end
end
