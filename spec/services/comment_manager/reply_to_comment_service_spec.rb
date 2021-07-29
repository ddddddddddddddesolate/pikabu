# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentManager::ReplyToCommentService do
  let(:result) { CommentManager::ReplyToCommentService.call(current_user, id, text) }

  let(:current_user) { nil }
  let(:id) { nil }
  let(:text) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and comment not exists' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'and comment exists' do
      let(:id) { create(:comment).id }

      context 'and text not present' do
        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'and text too long' do
        let(:text) { Faker::Lorem.characters(number: 256) }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
