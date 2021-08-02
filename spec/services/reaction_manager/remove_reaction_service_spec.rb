# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReactionManager::RemoveReactionService do
  let(:result) { described_class.call(reaction) }

  context 'when reaction exists' do
    let(:reaction) { create(:reaction) }

    it 'result successful' do
      expect(result.success).eql? true
    end
  end
end
