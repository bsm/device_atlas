require 'spec_helper'

describe DeviceAtlas::UAR::RuleSet do

  subject { SAMPLE_TREE.uar.rule_groups[14].rule_sets[0] }
  let(:searchable) { SAMPLE_TREE.uar.rule_groups[13].rule_sets[0] }

  it { should be_instance_of(described_class) }
  it { should have(3).rules }

  it "should indicate if serachable" do
    subject.should_not be_searchable
    searchable.should be_searchable
  end

  it "should determine if a UA is applicable" do
    subject.applicable?(SAMPLE_UA).should be(false)
    subject.applicable?(BLACKBERRY_UA).should be(true)
    searchable.applicable?(SAMPLE_UA).should be(false)
    searchable.applicable?(OPERA_UA).should be(false)
  end

  it "should determine if the set matches a UA" do
    subject.matches?(SAMPLE_UA).should be(false)
    subject.matches?(BLACKBERRY_UA).should be(false)
    searchable.matches?(SAMPLE_UA).should be(false)
    searchable.matches?(OPERA_UA).should be(true)
  end

end