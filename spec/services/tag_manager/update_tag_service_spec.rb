# frozen_string_literal: true

require "rails_helper"

RSpec.describe TagManager::UpdateTagService do
  let(:result) { described_class.call(tag, params) }

  let(:tag) { create(:tag) }

  context "when params is invalid" do
    let(:params) do
      {
        name: nil
      }
    end

    it "result not successful" do
      expect(result.success).eql? false
    end
  end
end
