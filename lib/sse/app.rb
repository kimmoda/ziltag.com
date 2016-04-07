# frozen_string_literal: true
require 'sinatra/base'

module SSE
  class App < Sinatra::Base
    set :logging, true
    set :ziltag_clients, {}
    set :map_clients, {}

    helpers do
      def broadcast_zilag slugs, event, data
        Array(slugs).each do |slug|
          Array(settings.ziltag_clients[slug]).each do |client|
            client << "event: #{event}\ndata: #{data.to_json}\n\n"
          end
        end
      end

      def broadcast_map map_id, event, data
        Array(settings.map_clients[map_id]).each do |client|
          client << "event: #{event}\ndata: #{data.to_json}\n\n"
        end
      end
    end

    before do
      headers(
        'Connection' => 'Keep-Alive',
        'Access-Control-Allow-Origin' => '*',
        'Content-Type' => 'text/event-stream',
        'Server' => 'Ziltag Push Server'
      )
    end

    not_found do
      '404 not found'
    end

    get %r{\A/api/v1/ziltags/(\w{6})/stream} do
      slug = params['captures'].first
      stream(:keep_open) do |out|
        settings.ziltag_clients[slug] ||= []
        settings.ziltag_clients[slug] << out
        logger.info "client #{object_id} is connecting ziltag #{slug}."
        out.callback do
          settings.ziltag_clients[slug].delete out
          settings.ziltag_clients.delete slug if settings.ziltag_clients[slug].empty?
          logger.info "client #{object_id} closed."
        end
      end
    end

    get %r{\A/api/v1/ziltag_maps/(\w{6})/stream} do
      slug = params['captures'].first
      stream(:keep_open) do |out|
        settings.map_clients[slug] ||= []
        settings.map_clients[slug] << out
        logger.info "client #{object_id} is connecting map #{slug}."
        out.callback do
          settings.map_clients[slug].delete out
          settings.map_clients.delete slug if settings.ziltag_clients[slug].empty?
          logger.info "client #{object_id} closed."
        end
      end
    end
  end
end
