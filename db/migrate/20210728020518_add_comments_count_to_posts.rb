# frozen_string_literal: true

class AddCommentsCountToPosts < ActiveRecord::Migration[6.1]
  def self.up
    add_column :posts, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :comments_count
  end
end
