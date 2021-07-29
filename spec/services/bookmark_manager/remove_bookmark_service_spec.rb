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

    context 'and model not exists' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'and model' do
      context 'of type post' do
        let(:model) { Post }

        context 'not exists' do
          it 'raise NotFoundError' do
            expect { result }.to raise_error Exceptions::NotFoundError
          end
        end

        context 'exists' do
          let(:id) { create(:post).id }

          context 'and not in bookmarks' do
            it 'raise NotFoundError' do
              expect { result }.to raise_error Exceptions::NotFoundError
            end
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

        context 'exists' do
          let(:id) { create(:comment).id }

          context 'and not in bookmarks' do
            it 'raise NotFoundError' do
              expect { result }.to raise_error Exceptions::NotFoundError
            end
          end
        end
      end
    end
  end
end
