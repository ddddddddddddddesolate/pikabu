# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::RenameTagService do
  let(:result) { described_class.call(id, name) }

  let(:id) { nil }
  let(:name) { nil }

  context 'when tag not exists' do
    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end

  context 'when tag' do
    let(:id) { create(:tag).id }

    context 'name not present' do
      it 'raise ValidationError' do
        expect { result }.to raise_error Exceptions::ValidationError
      end
    end

    context 'name too long' do
      let(:name) { Faker::Lorem.characters(number: 31) }

      it 'raise ValidationError' do
        expect { result }.to raise_error Exceptions::ValidationError
      end
    end

    context 'name already taken' do
      let(:name) { create(:tag).name }

      it 'raise ValidationError' do
        expect { result }.to raise_error Exceptions::ValidationError
      end
    end
  end
end
