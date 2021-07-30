# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostManager::UpdatePostService do
  let(:result) { described_class.call(current_user, id, title, text) }

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

    context 'and post' do
      context 'author is not current user' do
        let(:id) { create(:post, user: create(:user)).id }
        let(:title) { Faker::Lorem.characters(number: 50) }

        it 'raise NotFoundError' do
          expect { result }.to raise_error Exceptions::NotFoundError
        end
      end

      context 'of current user has' do
        let(:id) { create(:post, user: current_user).id }

        context 'blank title' do
          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'too long title' do
          let(:title) { Faker::Lorem.characters(number: 51) }

          it 'raise ValidationError' do
            expect { result }.to raise_error Exceptions::ValidationError
          end
        end

        context 'too long text' do
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
