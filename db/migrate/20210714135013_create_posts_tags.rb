# frozen_string_literal: true

class CreatePostsTags < ActiveRecord::Migration[6.1]
  def change
    create_table :posts_tags, id: false do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
