
module Crankshaft

  class Torrent

    # Default attributes fetched with each torrent
    ATTRS = [
      :addedDate, :comment, :creator, :dateCreated, :files, :hashString, :id, :isPrivate,
      :magnetLink, :name, :pieceCount, :pieceSize, :startDate, :trackers, :totalSize
    ]

    def initialize(session, attrs = {})
      @session = session
      @attrs = attrs
    end

    # Actions
    # -------

    def start
      arguments = { :ids => [ self['id'] ] }
      @session.execute('torrent-start', arguments)
    end

    def stop
      arguments = { :ids => [ self['id'] ] }
      @session.execute('torrent-stop', arguments)
    end

    def verify
      arguments = { :ids => [ self['id'] ] }
      @session.execute('torrent-verify', arguments)
    end

    def reannounce
      arguments = { :ids => [ self['id'] ] }
      @session.execute('torrent-reannounce')
    end

    def remove(delete = false)
      arguments = { :ids => [ self['id'] ], 'delete-local-data' => delete }
      @session.execute('torrent-delete', arguments)
    end


    # Attributes
    # ----------

    def [](attribute)
      return @attrs[attribute] if @attrs.include?(attribute)

      arguments = { :ids => [ self['id'] ], :fields => [ attribute ] }
      response = @session.execute('torrent-get', arguments)
      if response['result'] == 'success'
        attrs = response['arguments']['torrents'][0]
        return attrs[attribute]
      end
    end

    def method_missing(method, *args)
      self[method]
    end

    # Files
    # -----

    def files
      @files ||= begin
        self['files'].map do |file|
          Crankshaft::File.new(self, file)
        end
      end
    end

  end

end
