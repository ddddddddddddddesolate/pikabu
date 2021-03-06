# frozen_string_literal: true

class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  counter_culture :post, column_name: :tags_count
end
