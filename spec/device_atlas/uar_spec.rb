require 'spec_helper'

describe DeviceAtlas::UAR do

  subject { SAMPLE_TREE.uar }

  it { should be_instance_of(described_class) }
  it { should have(5).rule_groups }
  its(:rule_roups) { subject.first.should be_instance_of(DeviceAtlas::UAR::RuleGroup) }

end