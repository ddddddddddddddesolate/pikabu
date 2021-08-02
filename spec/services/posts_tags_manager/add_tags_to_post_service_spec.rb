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

    it "skip invalid tags and result successful" do
      expect { tags_count }.to_not change(&method(:tags_count))
      expect(result.success).eql? true
    end
  end
end
