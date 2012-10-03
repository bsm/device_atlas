require 'spec_helper'

describe DeviceAtlas::Property do

  subject { SAMPLE_TREE.properties.first }

  it { should be_a(String) }
  it { should == "is_browser" }
  its(:type) { should == :boolean }
  its(:id) { should == 0 }

  it 'should convert values' do
    subject.convert(1).should be(true)
    subject.convert(0).should be(false)
  end
  
end