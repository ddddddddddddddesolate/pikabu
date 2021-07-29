# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::CreateTagService do
  describe 'create tag' do
    let :result do
      TagManager::CreateTagService.call(name)
    end

    describe 'where tag name is invalid' do
      let :name do
        nil
      end

      it 'raise ValidationError' do
        expect { result }.to raise_error Exceptions::ValidationError
      end
    end
  end
end
