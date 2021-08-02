# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::DeleteTagService do
  let(:result) { described_class.call(tag) }

  context 'when tag exists' do
    let(:tag) { create(:tag) }

    it 'result successful' do
      expect(result.success).eql? true
    end
  end
end
