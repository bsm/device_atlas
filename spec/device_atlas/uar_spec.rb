require 'spec_helper'

describe DeviceAtlas::UAR do

  subject { SAMPLE_TREE.uar }

  it { should be_instance_of(described_class) }
  it { should have(16).rule_groups }
  it { should have(26).expressions }
  it { should have(7).skip_values }
  
  its(:rule_groups) { subject.first.should be_instance_of(DeviceAtlas::UAR::RuleGroup) }
  its(:expressions) { subject.first.should be_instance_of(Regexp) }
  its(:skip_values) { should be_instance_of(Array) }
  its(:skip_values) { should include(1) }

  describe "seeking" do

    it "should return nothing if a value is to be skipped" do
      subject.seek_ids(SAMPLE_UA, 5 => true).should == {}
    end

  end



end