class ZiltagDeviseMailer < Devise::Mailer
  layout 'mailer'

  def confirmation_instructions(record, token, opts = {})
    @token = token
    @username = record.username
    @box = record.box
    template = confirmation_template record
    initialize_from_record record
    mail headers_for(__method__, opts) do |format|
      format.html do
        render_inline_css template
      end
    end
  end

  private

  def confirmation_template user
    case user
    when ContentProvider then :confirmation_instructions_for_partner
    else :confirmation_instructions_for_user
    end
  end

end
