# frozen_string_literal: true

class AddDislikesCountToComments < ActiveRecord::Migration[6.1]
  def self.up
    add_column :comments, :dislikes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :comments, :dislikes_count
  end
end
