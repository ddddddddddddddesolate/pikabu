# frozen_string_literal: true

class RenamePostsTagsToPostTags < ActiveRecord::Migration[6.1]
  def self.up
    rename_table :posts_tags, :post_tags
    add_column :post_tags, :id, :primary_key
  end

  def self.down
    rename_table :post_tags, :posts_tags
    remove_column :posts_tags, :id
  end
end
