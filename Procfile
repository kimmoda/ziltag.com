web: bundle exec puma
sse: ruby lib/sse.rb -svp 3310 --ssl --ssl-key ../config/ssl/localhost.key --ssl-cert ../config/ssl/localhost.crt -c ./sse/config.rb
worker: env QUEUES="mailers,default" QC_MEASURE=true bundle exec rake qc:work
webpack: npm run dev
