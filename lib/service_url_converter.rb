module ServiceURLConverter
  module_function

  def convert params
    case params[:platform]
    when 'general' then params[:url]
    when 'tumblr' then "http://#{params[:blog_id]}.tumblr.com"
    when 'wordpress' then "http://#{params[:blog_id]}.wordpress.com"
    when 'blogger' then "http://#{params[:blog_id]}.blogspot.com"
    else raise 'unknown platform'
    end 
  end
end