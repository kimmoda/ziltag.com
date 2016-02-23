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

  def render_inline_css template
    premailer = Premailer.new(render_to_string(template),
      with_html_string: true,
      remove_classes: true,
      css_string: File.read(Rails.root.join('app/assets/stylesheets/mailer.css')),
      remove_scripts: false
    )
    render html: premailer.to_inline_css.html_safe
  end

  def confirmation_template user
    case user
    when ContentProvider then :confirmation_instructions_for_partner
    else :confirmation_instructions_for_user
    end
  end

end
