class DeviceAtlas::Tree

  # @attr_reader [DeviceAtlas::UAR] user agent specific rules
	attr_reader :uar

	# Constructor, optimises the tree for fast access
	# @param [Hash] the parsed lookup tree
	def initialize(tree)
		@uar = DeviceAtlas::UAR.new(tree["uar"])
	end

end
