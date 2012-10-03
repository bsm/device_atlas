require 'spec_helper'

describe DeviceAtlas::Tree do

	subject { SAMPLE_TREE }
  its(:properties) { should have(126).items }
  its(:properties) { subject.first.should be_instance_of(DeviceAtlas::Property) }
  its(:expressions) { should have(10).items }
  its(:uar) { should be_instance_of(DeviceAtlas::UAR) }
  its(:root) { should be_instance_of(DeviceAtlas::Tree::Node) }
	
  it 'should seek IDs' do
    result = subject.seek_ids(SAMPLE_UA)
    result.should have(104).keys
    result.keys.first.should be_instance_of(Fixnum)
    result[98].should be(false)
  end

  it 'should seek property values' do
    result = subject.seek(SAMPLE_UA)
    result.should have(104).keys
    result.keys.first.should be_instance_of(DeviceAtlas::Property)
    result["os_android"].should be(false)
  end

end