# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentManager::AddCommentToPostService do
  let(:result) { described_class.call(current_user, id, text) }

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

    context 'and post not exists' do
      it 'raise NotFoundError' do
        expect { result }.to raise_error Exceptions::NotFoundError
      end
    end

    context 'and post has' do
      let(:id) { create(:post).id }

      context 'blank text' do
        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'too long text' do
        let(:text) { Faker::Lorem.characters(number: 256) }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
