module ServiceURLConverter
  module_function

  def convert params
    case params[:platform]
    when 'general' then params[:url]
    when 'tumblr' then params[:blog_id]
    when 'wordpress' then params[:blog_id]
    when 'blogger' then params[:blog_id]
    else raise 'unknown platform'
    end 
  end
end