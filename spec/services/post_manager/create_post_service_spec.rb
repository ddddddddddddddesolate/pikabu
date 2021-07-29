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

    context 'and post has no images and tags' do
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

    context 'and post has images' do
      let(:title) { Faker::Lorem.characters(number: 50) }

      context 'and image url invalid' do
        let(:image_urls) { ['invalid.url'] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'and image url not present' do
        let(:image_urls) { [nil] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end

    context 'and post has tags' do
      let(:title) { Faker::Lorem.characters(number: 50) }

      context 'and tag name not present' do
        let(:tag_names) { [nil] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end

      context 'and tag name too long' do
        let(:tag_names) { [Faker::Lorem.characters(number: 31)] }

        it 'raise ValidationError' do
          expect { result }.to raise_error Exceptions::ValidationError
        end
      end
    end
  end
end
