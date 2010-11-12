
module Crankshaft

  class File

    def initialize(torrent, attrs)
      @torrent = torrent
      @attrs = attrs
    end

    def [](attribute)
      return @attrs[attribute] if @attrs.include?(attribute)
    end

  end

end