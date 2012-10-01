require 'spec_helper'

describe DeviceAtlas::UAR::RuleSet do

  subject { SAMPLE_TREE.uar.rule_groups.first.rule_sets.first }

  it { should be_instance_of(described_class) }
	it { should have(2).rules }

end