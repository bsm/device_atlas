require 'bundler/setup'
require 'rspec'
require 'device_atlas'
require 'oj'

SAMPLE_FILE = File.expand_path('../fixtures/sample.json', __FILE__)
SAMPLE_HASH = MultiJson.load(File.read(SAMPLE_FILE))
SAMPLE_TREE = DeviceAtlas::Tree.new(SAMPLE_HASH)
