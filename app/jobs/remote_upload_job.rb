class RemoteUploadJob < ActiveJob::Base
  queue_as :default

  def perform(record, mounted_column_name, url)
    record.update! "remote_#{mounted_column_name}_url" => url
  rescue ActiveRecord::RecordInvalid
    logger.info $!
    record.destroy
    logger.info "#{record.class} ##{record.id} with URL #{url} has been destroyed."
  end
end
