class DeviceAtlas::UAR::RuleGroup

  # @attr_reader [Array] rule sets
  attr_reader :rule_sets

  # @attr_reader [Hash<Property,Integer>] property values
  attr_reader :values

	# Constructor
	# @param [Hash] attributes the rule group attributes
	def initialize(attributes)
		@rule_sets = attributes["t"].map do |attrs|
			DeviceAtlas::UAR::RuleSet.new(attrs)
		end
    @values    = {}
	end  

  # @return [Array] properties
  def properties
    values.keys
  end

end