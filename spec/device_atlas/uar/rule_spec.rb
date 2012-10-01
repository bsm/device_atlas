require 'spec_helper'

describe DeviceAtlas::UAR::Rule do

  subject { SAMPLE_TREE.uar.rule_groups.first.rule_sets.first.rules.first }

  it { should be_instance_of(described_class) }
  its(:property_id) { should == 63 }

end