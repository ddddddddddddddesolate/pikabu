# frozen_string_literal: true

class AddBookmarksCountToUsers < ActiveRecord::Migration[6.1]
  def self.up
    add_column :users, :bookmarks_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :bookmarks_count
  end
end
