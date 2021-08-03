# frozen_string_literal: true

class AddTagsCountToPosts < ActiveRecord::Migration[6.1]
  def self.up
    add_column :posts, :tags_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :tags_count
  end
end
