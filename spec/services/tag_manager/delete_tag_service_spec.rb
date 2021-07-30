# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagManager::DeleteTagService do
  let(:result) { described_class.call(id) }

  let(:id) { nil }

  context 'where tag not exists' do
    it 'raise NotFoundError' do
      expect { result }.to raise_error Exceptions::NotFoundError
    end
  end
end
