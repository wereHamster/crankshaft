
Crankshaft
----------

Ruby bindings for the Transmission BitTorrent client.


Example
-------

    session = Crankshaft::Session.new('http://localhost:9091/transmission/rpc')
    session.torrents do |torrent|
      p torrent['name']
      torrent.verify
    end


License
-------

Copyright (c) 2010 by Tomas "wereHamster" Carnecky (tomas.carnecky@gmail.com)
