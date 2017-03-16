class Member < ApplicationRecord
  belongs_to :account
  has_many :visits
  has_many :aliases, inverse_of: :member

  acts_as_sequenced scope: :account_id
  accepts_nested_attributes_for :aliases

  validates_associated :aliases
  validates :name, presence: true
  validates :account, presence: true
  validates :sequential_id, presence: true

  def to_param
    self.sequential_id.to_s
  end
end
