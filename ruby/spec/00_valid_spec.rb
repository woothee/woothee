# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

module Woothee
end

describe Woothee do
  it "should be read from each modules correctly" do
    lambda { require 'woothee/dataset' }.should_not raise_error(LoadError)
    lambda { require 'woothee' }.should_not raise_error(LoadError)
  end
end
