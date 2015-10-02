# https://github.com/bblimke/webmock
module StubRequests
  def stub_request_for_image
    stub_request(:get, 'webmock.me/jpeg')
      .to_return(
        body: File.new(Rails.root.join('test', 'fixtures', 'images', '1.jpg')),
        status: 200,
        headers: {'Content-Type' => 'image/jpeg'}
      )
  end

  def stub_request_for_html
    stub_request(:get, 'webmock.me').to_return(body: '<h1>Hello World</h1>')
  end

  def stub_request_for_404
    stub_request(:get, 'webmock.me/notfound').to_return(status: 404)
  end
end