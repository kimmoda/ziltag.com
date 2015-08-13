if Rails.env.production?
  Elasticsearch::Model.client = Elasticsearch::Client.new Settings.elasticsearch
end