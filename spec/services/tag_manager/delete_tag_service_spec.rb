# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::DeleteTagService do
  let :result do
    TagManager::DeleteTagService.call(id)
  end

  context 'where tag not exists' do
    let :id do
      0
    end

    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end
end
