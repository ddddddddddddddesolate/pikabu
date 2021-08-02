# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentManager::UpdateCommentService do
  let(:result) { described_class.call(comment, params) }

  let(:comment) { create(:comment) }

  context 'when params is invalid' do
    let(:params) do
      {
        text: nil
      }
    end

    it 'result not successful' do
      expect(result.success).eql? false
    end
  end
end
