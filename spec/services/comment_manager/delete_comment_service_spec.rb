# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentManager::DeleteCommentService do
  let(:result) { described_class.call(comment) }

  let(:comment) { create(:comment) }

  context "when comment exists" do
    it "result successful" do
      expect(result.success).eql? true
    end
  end
end
