# frozen_string_literal: true

class RenameVoteToReaction < ActiveRecord::Migration[6.1]
  def change
    rename_table :votes, :reactions
    rename_column :reactions, :votable_id, :reactionable_id
    rename_column :reactions, :votable_type, :reactionable_type
  end
end
