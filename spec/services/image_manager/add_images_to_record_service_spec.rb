# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageManager::AddImagesToRecordService do
  let(:result) { described_class.call(record, image_urls) }

  let(:record) { create(:post) }

  context 'when images has invalid urls' do
    let(:image_urls) { [nil] }

    it 'result not successful' do
      expect(result.success).eql? false
    end
  end
end
