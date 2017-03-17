class Visit < ApplicationRecord
  belongs_to :account
  belongs_to :member

  validates :account, presence: true

  paginates_per 10

  def self.states
    OpenStruct.new({
      start: "start",
      visitor_name_given: "VisitorNameGiven",
      member_name_given: "MemberNameGiven",
      end: "end"
    })
  end
end
