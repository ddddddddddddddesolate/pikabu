# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostManager::CreatePostService do
  let(:result) { PostManager::CreatePostService.call(current_user, title, text, image_urls, tag_names) }

  let(:current_user) { nil }
  let(:title) { nil }
  let(:text) { nil }
  let(:image_urls) { nil }
  let(:tag_names) { nil }

  context 'when user not logged in' do
    it 'raise UnauthorizedError' do
      expect { result }.to raise_error Exceptions::UnauthorizedError
    end
  end

  context 'when user logged in' do
    let(:current_user) { create(:user) }

    context 'and post has' do
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

    context 'image has' do
      let(:title) { Faker::Lorem.characters(number: 50) }

      context 'invalid url' do
        let(:image_urls) { ['invalid.url'] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'blank url' do
        let(:image_urls) { [nil] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end

    context 'tag has' do
      let(:title) { Faker::Lorem.characters(number: 50) }

      context 'blank name' do
        let(:tag_names) { [nil] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'too long name' do
        let(:tag_names) { [Faker::Lorem.characters(number: 31)] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
