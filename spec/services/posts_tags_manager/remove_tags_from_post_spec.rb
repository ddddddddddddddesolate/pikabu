# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsTagsManager::RemoveTagsFromPostService do
  let(:result) { described_class.call(current_user, id, tag_ids) }

  let(:current_user) { nil }
  let(:id) { nil }
  let(:tag_ids) { nil }

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

    context 'and post' do
      context 'author is not current user' do
        let(:id) { create(:post, user: create(:user)).id }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'tags not present' do
        let(:id) { create(:post, user: current_user).id }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
