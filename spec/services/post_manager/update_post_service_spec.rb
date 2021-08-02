# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostManager::UpdatePostService do
  let(:result) { described_class.call(post, params) }

  let(:post) { create(:post) }

  context "when params is invalid" do
    let(:params) do
      {
        title: nil
      }
    end

    it "result not successful" do
      expect(result.success).eql? false
    end
  end
end
