require 'daily_reporter'
require 'time'
namespace :notifier do
  task :daily_report, [:time] => :environment do |t, args|
    args.with_defaults(time: Time.now.to_s)
    time = Time.parse(args.time)
    DailyReporter.new(time).report!
  end
end
