class DevisePreview < ActionMailer::Preview
  def confirmation_instructions
    ZiltagDeviseMailer.confirmation_instructions(User.first, "faketoken")
  end

  def password_reset
    ZiltagDeviseMailer.reset_password_instructions(User.first, "faketoken")
  end
end