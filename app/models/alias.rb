class Alias < ApplicationRecord
  belongs_to :member

  validates :name, presence: true
  validates :member_id, presence: true
end
