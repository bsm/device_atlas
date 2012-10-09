require 'spec_helper'

describe DeviceAtlas::UAR::RuleGroup do

  subject { SAMPLE_TREE.uar.rule_groups[2] }
  let(:no_reqs) { SAMPLE_TREE.uar.rule_groups[12] }
  let(:multiset) { SAMPLE_TREE.uar.rule_groups[14] }

  it { should be_instance_of(described_class) }
  it { should have(2).required }
  it { should have(1).rule_sets }
  its(:required) { should == { 107=>1, 102=>0 } }
  its(:rule_sets) { subject.first.should be_instance_of(DeviceAtlas::UAR::RuleSet) }

  it 'should check property/value pairs for full match' do
    subject.matches?(107=>1, 102=>0).should be(true)
    subject.matches?(107=>0, 102=>0).should be(false)
    subject.matches?(107=>1, 102=>0, 103=>1).should be(true)
    subject.matches?(107=>1).should be(false)

    no_reqs.required.should == {}
    no_reqs.matches?(1=>0).should be(false)
  end

  it 'should extract rules property/value pairs for full match' do
    subject.should have(1).rule_sets
    subject.should have(:no).rules(SAMPLE_UA, 100=>1)
    subject.should have(2).rules(SAMPLE_UA, 107=>1, 102=>0)

    multiset.should have(2).rule_sets
    multiset.should have(:no).rules(SAMPLE_UA, 100=>1)
    multiset.should have(:no).rules(SAMPLE_UA, 60=>1)
    multiset.should have(3).rules(BLACKBERRY_UA, 60=>1)
  end

end
