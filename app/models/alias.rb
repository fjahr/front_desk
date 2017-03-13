class Alias < ApplicationRecord
  belongs_to :member, inverse_of: :aliases

  validates :name, presence: true
  validates :member, presence: true
end
