# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookmarkManager::RemoveBookmarkService do
  let(:result) { described_class.call(bookmark) }

  context 'when bookmark exists' do
    let(:bookmark) { create(:bookmark) }

    it 'result successful' do
      expect(result.success).eql? true
    end
  end
end
