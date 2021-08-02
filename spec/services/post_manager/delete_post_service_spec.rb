# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostManager::DeletePostService do
  let(:result) { described_class.call(post) }

  let(:post) { create(:post) }

  context 'when post exists' do
    it 'result successful' do
      expect(result.success).eql? true
    end
  end
end
