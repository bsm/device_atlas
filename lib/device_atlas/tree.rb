class DeviceAtlas::Tree
  include DeviceAtlas::Helpers

  # @attr_reader [Array<String>] properties all properties
  attr_reader :properties

  # @attr_reader [Array] property values
  attr_reader :values

  # @attr_reader [Array<Regexp>] expressions
  attr_reader :expressions

  # @attr_reader [DeviceAtlas::UAR] user agent specific rules
  attr_reader :uar

  # @attr_reader [DeviceAtlas::Tree::Node] root the root node
  attr_reader :root

  # Constructor, optimises the tree for fast access
  # @param [Hash] the parsed lookup tree
  def initialize(tree)
    @properties  = tree["p"].map {|name| underscore(name.sub(/^(\w)/, '')).sub(/^is_/, '') }
    @values      = normalize tree["v"], [1, "True", "true"] => true, [0, "False", "false"] => false
    @expressions = Array(tree['r'][DeviceAtlas::API_ID]).map {|s| /#{s}/ }

    @uar  = DeviceAtlas::UAR.new(self, tree["uar"])
    @root = DeviceAtlas::Tree::Node.new(self, tree["t"])
  end

  # @param [String] ua the user agent string
  # @return [Hash<Integer,Integer>] pairs of property/value IDs
  def seek_ids(ua)
    pairs = {}
    root.send(:populate!, pairs, ua.to_s.dup)
    pairs
  end

  # @param [String] ua the user agent string
  # @return [Hash<String,Object>] pairs of property/value tuples
  def seek(ua)
    convert seek_ids(ua)
  end

  # @param [String] ua the user agent string
  # @return [Hash<Integer,Integer>] full property values, including UAR properties
  def match_ids(ua)
    pairs = seek_ids(ua)
    uar.update(pairs, ua)
  end

  # @param [String] ua the user agent string
  # @return [Hash<String,Object>] full property values, including UAR properties
  def match(ua)
    convert match_ids(ua)
  end

  private

    # Converts pairs of property/value IDs to property/value tuples
    def convert(pairs)
      Hash[properties.values_at(*pairs.keys).zip(values.values_at(*pairs.values))]
    end

    def normalize(values, replacements)
      replacements.each do |old, new|
        old.each do |value|
          values[values.index(value)] = new while values.include?(value)
        end
      end
      values
    end

end

%w|node|.each do |name|
  require "device_atlas/tree/#{name}"
end
