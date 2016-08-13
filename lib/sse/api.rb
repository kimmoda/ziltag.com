# frozen_string_literal: true
require 'grape'
module SSE
  class API < Grape::API #:nodoc:
    version 'v1', using: :path
    prefix :api

    helpers do
      def process_stream(resource_id, resource_name)
        env['subscription'] = env.channel.subscribe do |notification|
          if notification['receivers'][resource_name]&.include? resource_id
            env.stream_send "event: #{notification['event']}\ndata: #{notification['payload'].to_json}\n\n"
          end
        end
        env.logger.info "client: #{env['subscription']} connected to ziltags/#{resource_id}/stream"
      end
    end

    before do
      header 'Connection', 'Keep-Alive'
      header 'Access-Control-Allow-Origin', '*'
      header 'Content-Type', 'text/event-stream'
    end

    get 'ziltags/:id/stream' do
      process_stream params[:id], 'ziltags'
    end

    get 'ziltag_maps/:id/stream' do
      process_stream params[:id], 'ziltag_maps'
    end
  end
end
