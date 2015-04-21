CarrierWave.configure do |config|
  if Rails.env.production?
    Settings.carrierwave.each do |key, value|
      config.send("#{key}=", value.respond_to?(:symbolize_keys) ? value.symbolize_keys : value)
    end
  else
    config.asset_host = ActionController::Base.asset_host
  end
end