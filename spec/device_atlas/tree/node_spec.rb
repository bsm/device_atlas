require 'spec_helper'

describe DeviceAtlas::Tree::Node do

  subject { SAMPLE_TREE.root["M"]["o"]["zil"]["la"]["/"]["5"][".0"][" "]["("]["i"] }

  it { should be_instance_of(described_class) }
  it { should be_a(Hash) }
  its(:keys)  { should =~ ["D", "P"] }
  its(:pairs) { should == {109=>0, 108=>0, 105=>0, 95=>1, 60=>0, 7=>1} }

end