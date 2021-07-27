# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true

      t.timestamps
    end
  end
end
