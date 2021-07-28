# frozen_string_literal: true

class AddDislikesCountToPosts < ActiveRecord::Migration[6.1]
  def self.up
    add_column :posts, :dislikes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :dislikes_count
  end
end
