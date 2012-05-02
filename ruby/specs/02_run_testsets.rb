# -*- coding: utf-8 -*-

$LOAD_PATH.push '../lib' unless $LOAD_PATH.include?('../lib')

require 'yaml'
require 'woothee'

TESTSET_DIR = File.dirname(__FILE__) + "/../../testsets/";

TARGETS = [
           ['crawler.yaml','Crawler'],['crawler_google.yaml','Crawler/Google'],
           ['pc_windows.yaml','PC/Windows'],['pc_misc.yaml','PC/Misc'],
           ['mobilephone_docomo.yaml','MobilePhone/docomo'],['mobilephone_au.yaml','MobilePhone/au'],
           ['mobilephone_softbank.yaml','MobilePhone/softbank'],['mobilephone_willcom.yaml','MobilePhone/willcom'],
           ['mobilephone_misc.yaml','MobilePhone/misc'],
           ['smartphone_ios.yaml','SmartPhone/ios'],['smartphone_android.yaml','SmartPhone/android'],
           ['smartphone_misc.yaml','SmartPhone/misc'],
           ['appliance.yaml','Appliance'],
           ['pc_lowpriority.yaml','PC/LowPriority'],
           ['misc.yaml','Misc'],
           ['crawler_nonmajor.yaml','Crawler/NonMajor'],
          ]

describe Woothee do
  
  TARGETS.each do |filename,groupname|
    it groupname do 
      YAML.load_file(TESTSET_DIR + filename).each do |e|
        r = Woothee.parse(e['target'])
        r.should_not be_nil
        r[:name].should eql(e['name'])
        r[:category].should eql(e['category'])
        r[:os].should eql(e['os']) if e.has_key?('os')
        r[:version].should eql(e['version']) if e.has_key?('version')
        r[:vendor].should eql(e['vendor']) if e.has_key?('vendor')
      end
    end
  end

end
