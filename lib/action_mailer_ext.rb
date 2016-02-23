module ActionMailerExt
  def render_inline_css *args, &block
    premailer = Premailer.new(render_to_string(*args, &block),
      with_html_string: true,
      remove_classes: true,
      css_string: css_string,
      remove_scripts: false
    )
    render html: premailer.to_inline_css.html_safe
  end

  private

  def css_string
    load_css_string! if !Rails.env.production?
    @@css_string
  end

  def load_css_string!
    @@css_string = File.read(Rails.root.join('app/assets/stylesheets/mailer.css'))
  end
end

ActiveSupport.on_load(:action_mailer) do
  include ActionMailerExt
end