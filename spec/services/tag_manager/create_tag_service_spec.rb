# frozen_string_literal: true

require "rails_helper"

RSpec.describe TagManager::CreateTagService do
  let(:result) { described_class.call(params) }

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
