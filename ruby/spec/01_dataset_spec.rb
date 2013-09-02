# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

require 'woothee/dataset'

describe Woothee::DataSet do
  it "contains constants" do
    lambda { Woothee::ATTRIBUTE_NAME }.should_not raise_error()
    Woothee::ATTRIBUTE_NAME.should eql(:name)
  end

  it "contains list of categories/attributes" do
    lambda { Woothee::ATTRIBUTE_LIST }.should_not raise_error()
    lambda { Woothee::CATEGORY_LIST }.should_not raise_error()
    Woothee::ATTRIBUTE_LIST.should eql([
        Woothee::ATTRIBUTE_NAME, Woothee::ATTRIBUTE_CATEGORY, Woothee::ATTRIBUTE_OS,
        Woothee::ATTRIBUTE_VENDOR, Woothee::ATTRIBUTE_VERSION,
      ])
    Woothee::CATEGORY_LIST.should eql([
        Woothee::CATEGORY_PC, Woothee::CATEGORY_SMARTPHONE, Woothee::CATEGORY_MOBILEPHONE,
        Woothee::CATEGORY_CRAWLER, Woothee::CATEGORY_APPLIANCE, Woothee::CATEGORY_MISC,
        Woothee::VALUE_UNKNOWN,
      ])
  end

  it "contains dataset" do
    Woothee::DataSet.get('GoogleBot')[:name].should eql('Googlebot')
  end
end
