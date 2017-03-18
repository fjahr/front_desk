class MemberFinder
  def self.find(name)
    member = Member.where("LOWER(name) = ?", name.downcase).first

    unless member.present?
      al = Alias.where("LOWER(name) = ?", name.downcase).first
      member = al.member if al.present?
    end

    member
  end
end
