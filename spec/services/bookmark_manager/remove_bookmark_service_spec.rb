# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookmarkManager::RemoveBookmarkService do
  let(:result) { BookmarkManager::RemoveBookmarkService.call(current_user, model, id) }

  let(:current_user) { nil }
  let(:model) { nil }
  let(:id) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and type of bookmark not set' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'and post' do
      let(:model) { Post }

      context 'not exists' do
        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'not exists in bookmarks' do
        let(:id) { create(:post).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end
    end

    context 'of type comment' do
      let(:model) { Comment }

      context 'not exists' do
        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'not exists in bookmarks' do
        let(:id) { create(:comment).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end
    end
  end
end
