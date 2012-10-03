require 'spec_helper'

describe DeviceAtlas::UAR::RuleGroup do

  subject { SAMPLE_TREE.uar.rule_groups[2] }

  it { should be_instance_of(described_class) }
  it { should have(2).values }
  it { should have(1).rule_sets }
	its(:rule_sets) { subject.first.should be_instance_of(DeviceAtlas::UAR::RuleSet) }	

end
