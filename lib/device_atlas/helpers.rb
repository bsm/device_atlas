module DeviceAtlas::Helpers

  private

    def parse_pairs(tree, section)
      pairs = {}
      Array(section).each do |property_id, value_id|
        pairs[property_id.to_i] = value_id.to_i
      end
      pairs
    end

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