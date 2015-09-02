require 'content_retriever'
module StickersHelper
  def sticker_preview sticker
    c = ContentRetriever.new(sticker.content)
    if c.recognizer
      content_tag :div, class: 'layout-preview mdl-card' do
        render partial: c.recognizer.class.name.underscore, object: c.recognizer
      end
    end
  end

  def sticker_content sticker
    sanitize sticker.content.gsub URI.regexp(['http', 'https']), '<a href="\0" target="_blank">\1://\4/...</a>'
  end
end
