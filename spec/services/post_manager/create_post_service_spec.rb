# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostManager::CreatePostService do
  let(:result) { described_class.call(current_user, params, image_urls, tag_names) }

  let(:current_user) { create(:user) }
  let(:params) { nil }
  let(:image_urls) { nil }
  let(:tag_names) { nil }

  context "when params is invalid" do
    it "result not successful" do
      expect(result.success).eql? false
    end
  end

  context "when params is valid" do
    let(:params) { { title: Faker::Lorem.characters(number: 50) } }

    context "and images has invalid urls" do
      let(:image_urls) { [nil] }

      it "result not successful" do
        expect(result.success).eql? false
      end
    end

    context "and tags has invalid names" do
      let(:tag_names) { [nil] }

      it "result not successful" do
        expect(result.success).eql? false
      end
    end
  end
end
