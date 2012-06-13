# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

require 'woothee/dataset'

describe Woothee::DataSet do
  it "contains constants" do
    lambda { Woothee::ATTRIBUTE_NAME }.should_not raise_error(NameError)
    Woothee::ATTRIBUTE_NAME.should eql(:name)
  end

  it "contains dataset" do
    Woothee::DataSet.get('GoogleBot')[:name].should eql('Googlebot')
  end
end
