# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageManager::DeleteImageService do
  let(:result) { described_class.call(current_user, model, id, image_id) }

  let(:current_user) { nil }
  let(:model) { nil }
  let(:id) { nil }
  let(:image_id) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and imageable object not specified' do
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

      context 'author is not current user' do
        let(:id) { create(:post).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'does not contain this image' do
        let(:id) { create(:post, user: current_user).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end
    end

    context 'and comment' do
      let(:model) { Comment }

      context 'not exists' do
        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'author is not current user' do
        let(:id) { create(:comment).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'does not contain this image' do
        let(:id) { create(:comment, user: current_user).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end
    end
  end
end
