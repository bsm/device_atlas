require 'set'
require 'multi_json'

module DeviceAtlas
  API_ID = "6".freeze

  # @param [Hash] tree the raw tree hash
  # @return [DeviceAtlas::Tree] the parsed tree
  def self.parse(tree)
    DeviceAtlas::Tree.new(tree)
  end

  # @param [String] path the file path
  # @return [DeviceAtlas::Tree] the parsed tree
  def self.parse_file(path)
    parse MultiJson.load(File.read(path))
  end

end

%w|helpers tree uar|.each do |name|
  require "device_atlas/#{name}"
end
