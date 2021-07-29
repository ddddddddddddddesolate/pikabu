# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageManager::AddImageService do
  let(:result) { ImageManager::AddImageService.call(current_user, model, id, url) }

  let(:current_user) { nil }
  let(:model) { nil }
  let(:id) { nil }
  let(:url) { nil }

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

      context 'image has' do
        let(:id) { create(:post, user: current_user).id }

        context 'blank url' do
          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'invalid url' do
          let(:url) { 'invalid.url' }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
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

      context 'image has' do
        let(:id) { create(:comment, user: current_user).id }

        context 'blank url' do
          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'invalid url' do
          let(:url) { 'invalid.url' }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end
      end
    end
  end
end
