require 'spec_helper'

describe DeviceAtlas::Tree::Node do

  subject { SAMPLE_TREE.root["M"]["o"]["zil"]["la"]["/"]["5"][".0"][" "]["("]["i"] }

  it { should be_instance_of(described_class) }
  it { should be_a(Hash) }
  its(:values) { should == {109=>false, 108=>false, 105=>false, 95=>true, 60=>false, 7=>true} }
  its(:keys)   { should =~ ["D", "P"] }

end