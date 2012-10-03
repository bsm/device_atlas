class DeviceAtlas::UAR::RuleSet

  # @attr_reader [Array] specific rules
  attr_reader :rules

  # @attr_reader [Regexp,NilClass] refine
  attr_reader :refine
  
  # @attr_reader [Regexp,NilClass] search
  attr_reader :search

	# Constructor
  # @param [DeviceAtlas::UAR] uar the parent UAR
	# @param [Hash] attributes the rule set attributes
	def initialize(uar, attributes)
		@rules  = parse_rules(attributes["r"])
    @refine = uar.expressions[attributes["f"].to_i] if attributes["f"]
    @search = uar.expressions[attributes["s"].to_i] if attributes["s"]
	end

  private

    def parse_rules(section)
      section.map do |attrs|
        DeviceAtlas::UAR::Rule.new(attrs)
      end  
    end

end