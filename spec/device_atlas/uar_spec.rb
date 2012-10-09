require 'spec_helper'

describe DeviceAtlas::UAR do

  subject { SAMPLE_TREE.uar }

  it { should be_instance_of(described_class) }
  it { should have(16).rule_groups }
  it { should have(26).expressions }
  it { should have(2).searchable }
  it { should have(7).skip_on }

  its(:tree)        { should be_instance_of(DeviceAtlas::Tree) }
  its(:lookup)      { should be_instance_of(Hash) }
  its(:lookup)      { should have(16633).keys }
  its(:rule_groups) { subject.first.should be_instance_of(DeviceAtlas::UAR::RuleGroup) }
  its(:expressions) { subject.first.should be_instance_of(Regexp) }
  its(:skip_on)     { should be_instance_of(Array) }
  its(:skip_on)     { should include(1) }

  describe "finding rules" do

    it "should not search if pairs contain a value from the skip table" do
      subject.find_rules(SAMPLE_UA, 5 => 1).should == []
    end

    it "should find rules by matching" do
      subject.find_rules(BLACKBERRY_UA, 100 => 1).should == []
      subject.find_rules(BLACKBERRY_UA, 60 => 1).should have(3).items
    end

    it "should find rules by searching" do
      subject.find_rules(OPERA_UA, {}).should have(3).items
    end

  end

  describe "update" do
    let(:original) { {60 => 1} }

    it "should return original if no rules found" do
      subject.update({ 5 => 1 }, SAMPLE_UA).should == { 5 => 1 }
    end

    it "should update pairs" do
      subject.update(original, BLACKBERRY_UA).should == { 60=>1, 111=>301 }
      subject.update(original, OPERA_UA).should == { 60=>1, 111=>16636 }
      original.should have(2).keys
    end


  end

end