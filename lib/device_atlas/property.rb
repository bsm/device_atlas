class DeviceAtlas::Property < String

  TYPE_MAP = { "b" => :boolean, "i" => :integer, "s" => :string }.freeze

  # @attr_reader [Integer] id he ID
  attr_reader :id

  # @attr_reader [Symbol] type the type
  attr_reader :type

  # @param [Integer] id the ID
  # @param [String] name the name
  def initialize(id, name)
    name, prefix = name.sub(/^(\w)/, ''), $1

    @id   = id
    @type = TYPE_MAP[prefix] || raise("Unknown prefix #{prefix}:#{name}")
    super underscore(name)
  end

  # @param [Boolean,String,Integer] converted value
  # @return [Boolean,String,Integer] converted value
  def convert(value)
    case type
    when :boolean
      value == 1
    else
      value
    end
  end

  private

    # Shamelessly borrowed from ActiveSupport::Inflector 
    def underscore(word)
      word = word.to_s.dup
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end  

end
