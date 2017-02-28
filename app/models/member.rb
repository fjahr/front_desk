class Member < ApplicationRecord
  belongs_to :account
  acts_as_sequenced scope: :account_id

  def to_param
    self.sequential_id.to_s
  end
end
