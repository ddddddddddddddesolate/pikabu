class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :votable_id, uniqueness: { scope: [:votable_id, :votable_type],
                                       message: 'object already rated'}
end
