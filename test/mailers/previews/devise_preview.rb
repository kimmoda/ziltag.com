class DevisePreview < ActionMailer::Preview
  def confirmation_instructions
    ZiltagDeviseMailer.confirmation_instructions(User.first, "faketoken")
  end
end