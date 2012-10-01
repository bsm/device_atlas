require 'spec_helper'

describe DeviceAtlas::Tree do

	subject { SAMPLE_TREE }
	its(:uar) { should be_instance_of(DeviceAtlas::UAR) }
	
end