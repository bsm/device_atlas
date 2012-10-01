class DeviceAtlas::UAR::RuleSet

  # @attr_reader [Array] specific rules
	attr_reader :rules

	# Constructor
	# @param [Hash] attributes the rule set attributes
	def initialize(attributes)
		@rules = attributes["r"].map do |attrs|
			DeviceAtlas::UAR::Rule.new(attrs)
		end
	end

end