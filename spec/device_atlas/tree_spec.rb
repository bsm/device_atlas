require 'spec_helper'

describe DeviceAtlas::Tree do

	subject { SAMPLE_TREE }
  its(:properties)  { should have(126).items }
  its(:values)      { should have(16637).items }
  its(:expressions) { should have(10).items }
  its(:uar) { should be_instance_of(DeviceAtlas::UAR) }
  its(:root) { should be_instance_of(DeviceAtlas::Tree::Node) }

  it 'should normalize values' do
    subject.values[0].should be(false)
    subject.values[1].should be(true)
    subject.values[540].should be(false)
    subject.values[1743].should be(true)
    subject.values[13618].should be(false)
  end

  it 'should seek IDs' do
    result = subject.seek_ids(SAMPLE_UA)
    result.should have(104).keys
    result[62].should == 1743
    result[98].should == 0
    result[113].should == 1744
  end

  it 'should seek property/values' do
    result = subject.seek(SAMPLE_UA)
    result.should have(104).keys
    result["os_proprietary"].should be(true)
    result["os_android"].should be(false)
    result["vendor"].should == "Apple"
  end

  it 'should match IDs' do
    result = subject.match_ids(SAMPLE_UA)
    result.should have(105).keys
    result[112].should == 1556
  end

  it 'should match property/values' do
    result = subject.match(SAMPLE_UA)
    result.should have(105).keys
    result["browser_version"].should == "3.0"
  end

end