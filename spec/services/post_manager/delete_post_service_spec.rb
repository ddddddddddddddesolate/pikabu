# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostManager::DeletePostService do
  let(:result) { PostManager::DeletePostService.call(current_user, id) }

  let(:current_user) { nil }
  let(:id) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and post not exists' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'and post exists' do
      context 'and user not author of post' do
        let(:other_user) { create(:user) }
        let(:post) { create(:post, user: other_user) }
        let(:id) { post.id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end
    end
  end
end
