# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsTagsManager::AddTagsToPostService do
  let(:result) { PostsTagsManager::AddTagsToPostService.call(current_user, id, tag_names) }

  let(:current_user) { nil }
  let(:id) { nil }
  let(:tag_names) { nil }

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

      context 'tags has' do
        let(:id) { create(:post, user: current_user).id }

        context 'blank names' do
          let(:tag_names) { [nil] }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'too long names' do
          let(:tag_names) { [Faker::Lorem.characters(number: 31)] }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end
      end
    end
  end
end
