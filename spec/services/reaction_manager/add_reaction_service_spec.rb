# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReactionManager::AddReactionService do
  let(:result) { ReactionManager::AddReactionService.call(current_user, model, id, reaction) }

  let(:current_user) { nil }
  let(:model) { nil }
  let(:id) { nil }
  let(:reaction) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and ratable type not set' do
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

      context 'reaction not specified' do
        let(:id) { create(:post).id }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
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

      context 'reaction not specified' do
        let(:id) { create(:comment).id }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
