# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::CreateTagService do
  let(:result) { TagManager::CreateTagService.call(name) }

  let(:name) { nil }

  context 'when tag name not present' do
    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end

  context 'when tag name too long' do
    let(:name) { Faker::Lorem.characters(number: 31) }

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end
end
