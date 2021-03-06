class Member < ApplicationRecord
  belongs_to :account
  has_many :visits, dependent: :nullify
  has_many :aliases, inverse_of: :member, dependent: :destroy

  acts_as_sequenced scope: :account_id
  accepts_nested_attributes_for :aliases

  validates_associated :aliases
  validates :name, presence: true
  validates :account, presence: true

  paginates_per 10

  def to_param
    self.sequential_id.to_s
  end
end
