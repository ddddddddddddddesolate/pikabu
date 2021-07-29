# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::DeleteTagService do
  let(:result) { TagManager::DeleteTagService.call(id) }

  context 'where tag not exists' do
    let(:id) { nil }

    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end
end
