class EmbeddedController < ApplicationController
  layout false

  # GET /embedded/photos.json
  def photos
    image_urls = Array(params[:q])
    @url_hash = Hash[ image_urls.map{ |url| [URI(url).normalize.to_s, url] } ]
    @photos = Photo.search_by_urls(@url_hash.keys)
    headers['Access-Control-Allow-Origin'] = '*'
  end

  # GET /embedded/ziltagging/:id
  def ziltagging
    @ziltagging = Ziltagging.find params[:id]
    headers.delete 'X-Frame-Options'
  end

  def preview
    Rack::MiniProfiler.deauthorize_request
  end
end
