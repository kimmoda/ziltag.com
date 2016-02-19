module ServiceURLConverter
  class UnknownPlatform < StandardError; end
  class BlankBlogID < StandardError; end

  def self.convert params
    raise BlankBlogID if params[:platform] != 'general' && params[:blog_id].blank?
    case params[:platform]
    when 'general' then params[:url]
    when 'tumblr' then "http://#{params[:blog_id]}.tumblr.com"
    when 'wordpress' then "http://#{params[:blog_id]}.wordpress.com"
    when 'blogger' then "http://#{params[:blog_id]}.blogspot.com"
    else raise UnknownPlatform
    end
  end
end