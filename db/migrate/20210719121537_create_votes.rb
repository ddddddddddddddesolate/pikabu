# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :reaction
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
