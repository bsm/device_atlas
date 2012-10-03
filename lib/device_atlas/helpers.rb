module DeviceAtlas::Helpers

  private

    def parse_values(tree, section)
      result = {}      
      Array(section).each do |property_id, value|
        property = tree.properties[property_id.to_i]
        result[property.id] = property.convert(value)
      end
      result
    end

end