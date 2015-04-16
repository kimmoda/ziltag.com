CarrierWave.configure do |config|
  Settings.carrierwave.each do |key, value|
    config.send("#{key}=", value.respond_to?(:symbolize_keys) ? value.symbolize_keys : value)
  end
end if Rails.env.production?