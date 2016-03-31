CarrierWave.configure do |config|
  if Rails.env.production?
    Settings.carrierwave.each do |key, value|
      value = value.to_sym if key.to_s == 'storage'
      config.send("#{key}=", value.respond_to?(:symbolize_keys) ? value.symbolize_keys : value)
    end
  else
    config.asset_host = 'http://ziltag.dev'
  end
end