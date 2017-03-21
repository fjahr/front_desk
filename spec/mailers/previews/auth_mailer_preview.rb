class AuthMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    ::AuthMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    ::AuthMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    ::AuthMailer.unlock_instructions(User.first, "faketoken", {})
  end
end
