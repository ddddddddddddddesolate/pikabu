# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe TagManager::RenameTagService do
  let :result do
    TagManager::RenameTagService.call(id, name)
  end

  context 'where tag not exists' do
    let :id do
      0
    end

    let :name do
      Faker::Lorem.characters(number: 30)
    end

    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end

  context 'where tag name is invalid' do
    let :tag do
      create :tag
    end

    let :id do
      tag.id
    end

    let :name do
      nil
    end

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end

  context 'where tag name already taken' do
    let :first_tag do
      create :tag
    end

    let :second_tag do
      create :tag
    end

    let :id do
      first_tag.id
    end

    let :name do
      second_tag.name
    end

    it 'raise ValidationError' do
      expect { result }.to raise_error Exceptions::ValidationError
    end
  end
end
