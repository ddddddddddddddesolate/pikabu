# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostManager::UpdatePostService do
  let(:result) { PostManager::UpdatePostService.call(current_user, id, title, text) }

  let(:current_user) { nil }
  let(:id) { nil }
  let(:title) { nil }
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

    context 'and post exists' do
      context 'and user not author of post' do
        let(:other_user) { create(:user) }
        let(:post) { create(:post, user: other_user).id }
        let(:title) { Faker::Lorem.characters(number: 50) }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'and user author of post' do
        let(:id) { create(:post, user: current_user).id }

        context 'and title not present' do
          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'and title too long' do
          let(:title) { Faker::Lorem.characters(number: 51) }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'and text too long' do
          let(:title) { Faker::Lorem.characters(number: 50) }
          let(:text) { Faker::Lorem.characters(number: 256) }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end
      end
    end
  end
end
