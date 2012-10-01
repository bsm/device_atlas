class DeviceAtlas::UAR

  # @attr_reader [Array] rule groups
  attr_reader :rule_groups

  # Constructor
  # @param [Hash] attributes the UAR branch
  def initialize(attributes)
    @rule_groups = attributes["rg"].map do |attrs|
      DeviceAtlas::UAR::RuleGroup.new(attrs)
    end
  end

end

%w|rule_group rule_set rule|.each do |name|
  require "device_atlas/uar/#{name}"
end
