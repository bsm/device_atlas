#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'device_atlas'
require 'benchmark'

file = File.expand_path('../../spec/fixtures/sample.json', __FILE__)
hash = MultiJson.load(File.read(file))
tree = DeviceAtlas::Tree.new(hash)

ua1 = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0".freeze
ua2 = "BlackBerry9700/5.0.0.593 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/1".freeze
ua3 = "Opera/9.80 (Android 2.2; Opera Mobi/-2118645896; U; pl) Presto/2.7.60 Version/10.5".freeze

Benchmark.bm(15) do |x|

  x.report "UA1" do
    10_000.times { tree.match(ua1) }
  end

  x.report "UA2" do
    10_000.times { tree.match(ua2) }
  end

  x.report "UA3" do
    10_000.times { tree.match(ua3) }
  end

end