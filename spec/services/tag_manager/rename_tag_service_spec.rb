# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe TagManager::RenameTagService do
  let(:result) { TagManager::RenameTagService.call(id, name) }

  context 'when tag not exists' do
    let(:id) { nil }
    let(:name) { Faker::Lorem.characters(number: 30) }

    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end

  context 'when tag name is not present' do
    let(:id) { create(:tag).id }
    let(:name) { nil }

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end

  context 'when tag name is too long' do
    let(:id) { create(:tag).id }
    let(:name) { Faker::Lorem.characters(number: 31) }

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end

  context 'when tag name already taken' do
    let(:id) { create(:tag).id }
    let(:name) { create(:tag).name }

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end
end
