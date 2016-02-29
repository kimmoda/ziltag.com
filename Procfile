web: bundle exec puma
sse: bin/rails r lib/sse.rb
worker: env QUEUES="mailers,default" QC_MEASURE=true bundle exec rake qc:work
webpack: npm run dev