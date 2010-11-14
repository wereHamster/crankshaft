require 'helper'

class TorrentTest < Test::Unit::TestCase

  context "Torrent" do

    setup do
      @torrent = Crankshaft::Torrent.new(nil, { :attr => :value })
    end

    should "set attributes given in constructor" do
      assert_equal(:value, @torrent[:attr])
    end

    should "accept string as attribute keys" do
      assert_equal(:value, @torrent['attr'])
    end

    should "forward missing methods to attribute" do
      assert_equal(:value, @torrent.attr)
    end

  end

end
