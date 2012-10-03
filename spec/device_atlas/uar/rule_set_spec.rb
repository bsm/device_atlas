require 'spec_helper'

describe DeviceAtlas::UAR::RuleSet do

  subject { SAMPLE_TREE.uar.rule_groups[14].rule_sets[0] }

  it { should be_instance_of(described_class) }
  it { should have(3).rules }
  its(:refine) { should be_instance_of(Regexp) }
  its(:search) { should be_nil }

end