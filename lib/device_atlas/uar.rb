class DeviceAtlas::UAR

  # @attr_reader [DeviceAtlas::Tree] tree
  attr_reader :tree

  # @attr_reader [Hash] lookup of value IDs, by name
  attr_reader :lookup

  # @attr_reader [Array] rule_groups rule groups
  attr_reader :rule_groups

  # @attr_reader [Array] searchable rule sets
  attr_reader :searchable

  # @attr_reader [Array] skip_on skip if any of these properties if set to true
  attr_reader :skip_on

  # @attr_reader [Array] expressions regular expressions
  attr_reader :expressions

  # Constructor
  # @param [DeviceAtlas::Tree] tree parent tree reference
  # @param [Hash] attributes the UAR branch
  def initialize(tree, attributes)
    @tree        = tree
    @lookup      = Hash[tree.values.each_with_index.to_a]
    @expressions = parse_expressions(attributes["reg"])
    @rule_groups = parse_rule_groups(attributes["rg"])
    @searchable  = rule_groups.map {|group| group.rule_sets.select(&:searchable?) }.flatten
    @skip_on     = Array(attributes["sk"])
  end

  # @param [Hash<Integer,Integer>] pairs of known property/value IDs
  # @param [String] ua the user agent string
  # @return [Hash<Integer,Integer>] merged property/value IDs
  def update(pairs, ua)
    find_rules(ua, pairs).each do |rule|
      value_id = rule.value_id(ua)
      pairs.update(rule.property_id => value_id) if value_id
    end
    pairs
  end

  # @param [String] ua the user agent string
  # @param [Hash<Integer,Integer>] pairs of known property/value IDs
  # @return [Array<DeviceAtlas::UAR::Rule>] matching rule
  def find_rules(ua, pairs)
    return [] if pairs.values_at(*skip_on).any? {|v| v && v > 0 }

    rules = rule_groups.map do |rule_group|
      rule_group.rules(ua, pairs)
    end + searchable.map do |rule_set|
      rule_set.matches?(ua) ? rule_set.rules : []
    end
    rules.flatten
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
