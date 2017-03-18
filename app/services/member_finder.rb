class MemberFinder
  def self.find(account, name)
    member = account.members.where("LOWER(members.name) = ?", name.downcase).first

    unless member.present?
      al = account.aliases.where("LOWER(aliases.name) = ?", name.downcase).first
      member = al.member if al.present?
    end

    member
  end
end
