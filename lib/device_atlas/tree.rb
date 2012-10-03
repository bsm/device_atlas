class DeviceAtlas::Tree

  # @attr_reader [Array<DeviceAtlas::Property>] properties all properties
  attr_reader :properties

  # @attr_reader [Array<Regexp>] expressions
  attr_reader :expressions

  # @attr_reader [DeviceAtlas::UAR] user agent specific rules
  attr_reader :uar

  # @attr_reader [DeviceAtlas::Tree::Node] root the root node
  attr_reader :root

	# Constructor, optimises the tree for fast access
	# @param [Hash] the parsed lookup tree
	def initialize(tree)
    @properties  = tree["p"].each_with_index.map {|name, index| DeviceAtlas::Property.new(index, name) }    
    @expressions = Array(tree['r'][DeviceAtlas::API_ID]).map {|s| /#{s}/ }

		@uar  = DeviceAtlas::UAR.new(self, tree["uar"])
    @root = DeviceAtlas::Tree::Node.new(self, tree["t"])
	end

  # @param [String] ua the user agent string
  # @return [Hash<Integer,Object>] property values
  def seek_ids(ua)
    values = {}
    root.send(:populate!, values, ua.to_s.dup)
    values
  end

  # @param [String] ua the user agent string
  # @return [Hash<DeviceAtlas::Property>,Object>] property values
  def seek(ua)
    pairs = seek_ids(ua)
    Hash[properties.values_at(*pairs.keys).zip(pairs.values)]
  end

  # @param [String] ua the user agent string
  # @return [Hash<DeviceAtlas::Property>,Object>] property values
  def match(ua)
    base = seek_ids(ua)
    base.update uar.seek_ids(ua, base)
    Hash[properties.values_at(*base.keys).merge(base.values)]
  end

end

%w|node|.each do |name|
  require "device_atlas/tree/#{name}"
end
