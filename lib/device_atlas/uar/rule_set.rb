class DeviceAtlas::UAR::RuleSet

  # @attr_reader [Array] specific rules
  attr_reader :rules

	# Constructor
  # @param [DeviceAtlas::UAR] uar the parent UAR
	# @param [Hash] attributes the rule set attributes
	def initialize(uar, attributes)
		@rules  = parse_rules(uar, attributes["r"])
    @refine = uar.expressions[attributes["f"].to_i] if attributes["f"]
    @search = uar.expressions[attributes["s"].to_i] if attributes["s"]
	end

  # @param [String] ua the user agent
  # @return [Boolean] true if set is applicable, used for filtering
  def applicable?(ua)
    !!(@refine && ua =~ @refine)
  end

  # @param [String] ua the user agent
  # @return [Boolean] true if set matches, used for searching
  def matches?(ua)
    !!(@search && ua =~ @search)
  end

  # @return [Boolean] true if set is searchable
  def searchable?
    !!@search
  end

  private

    def parse_rules(uar, section)
      section.map do |attrs|
        DeviceAtlas::UAR::Rule.new(uar, attrs)
      end
    end

end