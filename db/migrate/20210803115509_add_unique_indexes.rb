# frozen_string_literal: true

class AddUniqueIndexes < ActiveRecord::Migration[6.1]
  def self.up
    add_index :users, :email, unique: true, name: :index_unique_user_email
    add_index :tags, :name, unique: true, name: :index_unique_tag_name
    add_index :reactions, %i[user_id reactionable_id reactionable_type], unique: true,
                                                                         name: :index_unique_user_reactions
    add_index :bookmarks, %i[user_id bookmarkable_id bookmarkable_type], unique: true,
                                                                         name: :index_unique_user_bookmarks
  end

  def self.down
    remove_index :users, name: :index_unique_user_email
    remove_index :tags, name: :index_unique_tag_name
    remove_index :reactions, name: :index_unique_user_reactions
    remove_index :bookmarks, name: :index_unique_user_bookmarks
  end
end
