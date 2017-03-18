class MemberFinder
  def self.find(name)
    Member.where("LOWER(name) = ?", name.downcase).first
  end

end
