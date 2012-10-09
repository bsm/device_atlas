class DeviceAtlas::UAR::Rule

  # @attr_reader [Integer] property ID
  attr_reader :property_id

  # @attr_reader [Regexp] expression
  attr_reader :expression

  # @attr_reader [Integer] match position
  attr_reader :position

  # Constructor
  # @param [Hash] attributes the rule attributes
  def initialize(uar, attributes)
    @uar         = uar
    @property_id = attributes["p"].to_i
    @value_id    = attributes["v"].to_i if attributes.key?("v")
    @expression  = uar.expressions[attributes["r"].to_i]
    @position    = attributes["m"].to_i
  end

  # @param [String] ua the user agent
  # @return [Integer] extracted value ID
  def value_id(ua)
    @value_id ? @value_id : @uar.lookup[expression.match(ua).to_a[position]]
  end

end