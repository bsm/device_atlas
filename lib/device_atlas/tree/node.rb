class DeviceAtlas::Tree::Node < Hash
  include DeviceAtlas::Helpers

  # @attr_reader [Hash<Integer, Integer>] pairs pairs of property/values ID
  attr_reader :pairs

  # @attr_reader [Array<Regexp>] expressions expressions to be substituted
  attr_reader :expressions

  # Constructor
  # @param [DeviceAtlas::Tree] tree parent tree reference
  # @param [Hash] attributes node attributes
  def initialize(tree, attributes)
    @expressions  = []
    @expressions |= tree.expressions.values_at(*attributes["r"]) if attributes.key?("r")
    @pairs        = parse_pairs(tree, attributes["d"])

    attributes["c"].map do |char, attrs|
      self[char] = self.class.new(tree, attrs)
    end if attributes.key?("c")
  end

  protected

    # @param [Hash] pairs the pairs accumulator
    # @param [String] string the remaining user agent string
    def populate!(pairs, string)
      pairs.update(self.pairs)
      return if empty?

      expressions.each do |regexp|
        string.gsub! regexp, ""
      end

      (1..string.size).each do |pos|
        child = self[string[0,pos]]
        return child.send(:populate!, pairs, string[pos..-1]) if child
      end
    end

end
