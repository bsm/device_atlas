require 'spec_helper'

describe DeviceAtlas do

  it "should parse hashes" do
    tree = described_class.parse SAMPLE_HASH
    tree.should be_instance_of(DeviceAtlas::Tree)
    tree.properties.should == SAMPLE_TREE.properties
  end

  it "should parse files" do
    tree = described_class.parse_file SAMPLE_FILE
    tree.should be_instance_of(DeviceAtlas::Tree)
    tree.properties.should == SAMPLE_TREE.properties
  end

end