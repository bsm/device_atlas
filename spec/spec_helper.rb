require 'bundler/setup'
require 'rspec'
require 'device_atlas'
require 'oj'

SAMPLE_FILE = File.expand_path('../fixtures/sample.json', __FILE__)
SAMPLE_HASH = MultiJson.load(File.read(SAMPLE_FILE))
SAMPLE_TREE = DeviceAtlas::Tree.new(SAMPLE_HASH)
SAMPLE_UA   = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0".freeze
BLACKBERRY_UA = "BlackBerry9700/5.0.0.593 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/1".freeze
OPERA_UA = "Opera/9.80 (Android 2.2; Opera Mobi/-2118645896; U; pl) Presto/2.7.60 Version/10.5".freeze