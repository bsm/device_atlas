class DeviceAtlas::UAR

  # @attr_reader [DeviceAtlas::Tree] tree
  attr_reader :tree

  # @attr_reader [Array] rule_groups rule groups
  attr_reader :rule_groups

  # @attr_reader [Hash] skip_values property values to skip
  attr_reader :skip_values

  # @attr_reader [Array] expressions regular expressions
  attr_reader :expressions

  # Constructor
  # @param [DeviceAtlas::Tree] tree parent tree reference
  # @param [Hash] attributes the UAR branch
  def initialize(tree, attributes)
    @tree        = tree
    @expressions = parse_expressions(attributes["reg"])
    @rule_groups = parse_rule_groups(attributes["rg"])
    @skip_values = Array(attributes["sk"])
  end

  # @param [String] ua the user agent string
  # @param [Hash<DeviceAtlas::Property>,Object>] values known property values
  # @return [Hash<DeviceAtlas::Property>,Object>] new property values
  def seek_ids(ua, values)
    return {} if values.values_at(*skip_values).any?
    { :to => "do" }
  end

  private 

    def parse_expressions(section)
      result = section["d"].map {|s| /#{s}/ }
      section[DeviceAtlas::API_ID].each do |index, s|
        result[index.to_i] = /#{s}/
      end if section.key?(DeviceAtlas::API_ID)      
      result
    end

    def parse_rule_groups(section)
      section.map do |attrs|
        DeviceAtlas::UAR::RuleGroup.new(self, attrs)
      end
    end

end

%w|rule_group rule_set rule|.each do |name|
  require "device_atlas/uar/#{name}"
end
