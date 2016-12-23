class HTTPRequest < ActiveRecord::Base
  def self.this_day(time = Time.now)
    where(created_at: time.ago(1.day)..time)
  end

  def self.referers(time = Time.now)
    result = this_day(time)
      .where('path NOT LIKE ? AND referer NOT LIKE ? AND referer NOT LIKE ? AND referer NOT LIKE ?', '/api%', 'https://ziltag.com%', 'https://preview.ziltag.com%', 'http://ziltag.com%')
      .group(:referer).count.sort_by(&:last)
    result.reject! { |url, count| url.empty? }
    result.reverse!
    result
  end

  def self.number_of_unique_visiters(time = Time.now)
    this_day(time).select(:session_id).group(:session_id).length
  end

  def self.active_websites(time = Time.now)
    data = this_day(time)
      .select(:params)
      .where(path: '/api/v1/ziltags')
      .pluck(:params)
    data.reject! do |params|
      params['href'].nil? ||
        params['href'].start_with?(
          'https://ziltag.com',
          'https://staging.ziltag.com',
          'https://tonytonyjan.net',
          'http://localhost'
        )
    end
    data.map! do |params|
      begin
        uri = URI(params['href'])
        "#{uri.scheme}://#{uri.host}"
      rescue
        nil
      end
    end
    data.compact!
    data = data.each_with_object(Hash.new(0)) { |url, hash| hash[url] += 1 }
    data = data.sort_by(&:last)
    data.reverse!
    data
  end
end
