require 'set'
require 'multi_json'

module DeviceAtlas
	API_ID = "6".freeze
end

%w|helpers tree uar property|.each do |name|
	require "device_atlas/#{name}"
end
