# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookmarkManager::CreateBookmarkService do
  let(:result) { described_class.call(current_user, record) }

  let(:current_user) { create(:user) }

  context 'when record is not bookmarkable' do
    let(:record) { create(:tag) }

    it 'result not successful' do
      expect(result.success).eql? false
    end
  end
end
