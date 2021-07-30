# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentManager::DeleteCommentService do
  let(:result) { described_class.call(current_user, id) }

  let(:current_user) { nil }
  let(:id) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and comment not present' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'not author of comment' do
      let(:id) { create(:comment).id }

      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end
  end
end
