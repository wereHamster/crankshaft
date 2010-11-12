
require 'base64'
require 'json'
require 'net/http'
require 'uri'

module Crankshaft

  class Session

    def initialize(url, timeout = 2)
      @uri = URI.parse(url)
      @timeout = timeout
    end

    def execute(method, arguments = {})
      begin
        request = { :method => method, :arguments => arguments }
        response = connection.post(@uri.path, request.to_json, @headers)
        if response.class == Net::HTTPConflict
          @headers = { 'X-Transmission-Session-Id' => response['X-Transmission-Session-Id'] }
          return execute(method, arguments)
        end

        return JSON.parse(response.body)
      rescue Exception => e
        @connection = nil
        throw "Failed to execute request: #{e.message}"
      end
    end

    def add(file, options = {})
      arguments = { :metainfo => Base64.encode64(file) }.merge(options)
      response = execute('torrent-add', arguments)
      if response['result'] == 'success'
        attrs = response['arguments']['torrent-added']
        if attrs
          return Crankshaft::Torrent.new(self, attrs)
        end
      end
    end

    def torrents(*attrs)
      arguments = { :fields => Crankshaft::Torrent::ATTRS }
      response = execute('torrent-get', arguments)

      return response['arguments']['torrents'].map do |attrs|
        Crankshaft::Torrent.new(self, attrs)
      end
    end

    def torrent(hash, *attrs)
      arguments = { :ids => [ hash ], :fields => Crankshaft::Torrent::ATTRS + attrs }
      response = execute('torrent-get', arguments)
      if response['result'] == 'success'
        attrs = response['arguments']['torrents'][0]
        if attrs
          return Crankshaft::Torrent.new(self, attrs)
        end
      end
    end

  private

    def connection
      @connection ||= begin
        http = Net::HTTP.new(@uri.host, @uri.port) do |http|
          http.read_timeout = @timeout
        end
      end
    end

  end

end
