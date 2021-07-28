# frozen_string_literal: true

class AddLikesCountToComments < ActiveRecord::Migration[6.1]
  def self.up
    add_column :comments, :likes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :comments, :likes_count
  end
end
