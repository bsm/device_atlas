class DeviceAtlas::UAR::RuleGroup
  include DeviceAtlas::Helpers

  # @attr_reader [Array] rule sets
  attr_reader :rule_sets

  # @attr_reader [Hash<Integer,Integer>] required property/value IDs
  attr_reader :required

	# Constructor
  # @param [DeviceAtlas::UAR] uar the parent UAR
	# @param [Hash] attributes the rule group attributes
	def initialize(uar, attributes)
		@rule_sets = parse_rule_sets(uar, attributes["t"])
    @required  = parse_pairs(uar.tree, attributes["p"])
	end

  # @param [Hash] pairs pairs of property/value IDs
  def matches?(pairs)
    return false if required.empty?
    required.all? {|pid, vid| pairs[pid] == vid }
  end

  # @param [String] ua the user agent
  # @param [Hash] pairs pairs of property/value IDs
  # @return [Array<DeviceAtlas::UAR::Rule>] list of rules
  def rules(ua, pairs)
    return [] unless matches?(pairs)

    if rule_sets.size == 1
      rule_sets[0].rules
    else # Filter down matching rule sets
      rule_sets.map do |set|
        set.applicable?(ua) ? set.rules : []
      end.flatten
    end
  end

  private

    def parse_rule_sets(uar, section)
      section.map do |attrs|
        DeviceAtlas::UAR::RuleSet.new(uar, attrs)
      end
    end

end