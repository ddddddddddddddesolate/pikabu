# frozen_string_literal: true

class RemoveUserFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :user_id
  end
end
