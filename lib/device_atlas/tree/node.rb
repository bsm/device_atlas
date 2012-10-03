class DeviceAtlas::Tree::Node < Hash
  include DeviceAtlas::Helpers

  # @attr_reader [Hash<Integer, Object>] values values by property ID
  attr_reader :values

  # @attr_reader [Array<Regexp>] expressions expressions to be substituted
  attr_reader :expressions

  # Constructor
  # @param [DeviceAtlas::Tree] tree parent tree reference
  # @param [Hash] attributes node attributes
  def initialize(tree, attributes)    
    @expressions  = [] 
    @expressions |= tree.expressions.values_at(*attributes["r"]) if attributes.key?("r")
    @values       = parse_values(tree, attributes["d"])

    attributes["c"].map do |char, attrs|
      self[char] = self.class.new(tree, attrs)
    end if attributes.key?("c")
  end

  protected

    # @param [Hash] values the values accumulator
    # @param [String] string the remaining user agent string
    def populate!(values, string)
      values.update(self.values)
      return if empty?

      expressions.each do |regexp|
        string.gsub! regexp, ""
      end

      buffer, child = "", nil
      until string.empty?
        buffer += string.slice!(0)
        child   = self[buffer]
        return child.send(:populate!, values, string) if child
      end
    end

end
