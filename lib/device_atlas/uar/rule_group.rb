class DeviceAtlas::UAR::RuleGroup
  include DeviceAtlas::Helpers

  # @attr_reader [Array] rule sets
  attr_reader :rule_sets

  # @attr_reader [Hash<Property,Integer>] property values
  attr_reader :values

	# Constructor
  # @param [DeviceAtlas::UAR] uar the parent UAR
	# @param [Hash] attributes the rule group attributes
	def initialize(uar, attributes)
		@rule_sets = parse_rule_sets(uar, attributes["t"])    
    @values    = parse_values(uar.tree, attributes["p"])
	end  

  # @return [Array] properties
  def properties
    values.keys
  end

  private 

    def parse_rule_sets(uar, section)
      section.map do |attrs|
        DeviceAtlas::UAR::RuleSet.new(uar, attrs)
      end
    end

end