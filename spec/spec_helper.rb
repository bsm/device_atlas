require 'bundler/setup'
require 'rspec'
require 'device_atlas'
require 'oj'

SAMPLE_FILE = File.expand_path('../fixtures/sample.json', __FILE__)
SAMPLE_HASH = MultiJson.load(File.read(SAMPLE_FILE))
SAMPLE_TREE = DeviceAtlas::Tree.new(SAMPLE_HASH)
SAMPLE_UA   = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0".freeze