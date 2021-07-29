# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookmarkManager::CreateBookmarkService do
  let(:result) { BookmarkManager::CreateBookmarkService.call(current_user, model, id) }

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

      context 'exists in bookmarks' do
        let(:bookmark) { create(:bookmark, :for_post, user: current_user, bookmarkable: create(:post)) }
        let(:id) { bookmark.bookmarkable_id }

        it 'raise AlreadyExistsError' do
          expect { result }.to raise_error Exceptions::AlreadyExistsError
        end
      end
    end

    context 'comment' do
      let(:model) { Comment }

      context 'not exists' do
        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'exists in bookmarks' do
        let(:bookmark) { create(:bookmark, :for_comment, user: current_user, bookmarkable: create(:comment)) }
        let(:id) { bookmark.bookmarkable_id }

        it 'raise AlreadyExistsError' do
          expect { result }.to raise_error Exceptions::AlreadyExistsError
        end
      end
    end
  end
end

