class DeviceAtlas::UAR::Rule

  # @attr_reader [Array] specific rules
  attr_reader :property_id

  # Constructor
  # @param [Hash] attributes the rule attributes
  def initialize(attributes)
    @property_id = attributes["p"].to_i
  end

end