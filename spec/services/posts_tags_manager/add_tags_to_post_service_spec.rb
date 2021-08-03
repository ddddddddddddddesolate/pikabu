# frozen_string_literal: true

require "rails_helper"

def tags_count
  result.post.tags.count
end

RSpec.describe PostsTagsManager::AddTagsToPostService do
  let(:result) { described_class.call(post, tag_names) }

  let(:post) { create(:post) }

  context "when tags has invalid names" do
    let(:tag_names) { [nil] }

    it "skip invalid tags" do
      expect { post.tags.count }.not_to change(post.tags, :count)
    end

    it "has successful result" do
      expect(result.success).eql? true
    end
  end
end
