var expect = require('chai').expect;

require('js-yaml');

var woothee = require('../lib/woothee'),
    dataset = require('../lib/dataset');

var TESTSET_DIR = process.cwd() + '/../testsets/',
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
      ['crawler_nonmajor.yaml','Crawler/NonMajor']
    ];

describe('woothee', function(){
  TARGETS.forEach(function(pair){
    var filename = pair[0],
        groupname = pair[1];
    var testset = require(TESTSET_DIR + filename);

    testset.forEach(function(entry){

      var result = woothee.parse(entry.target);

      dataset.ATTRIBUTE_LIST.forEach(function(attr){
        it(groupname + 'test(' + attr + '): ' + entry.target, function(){

          switch (attr) {
          case dataset.ATTRIBUTE_NAME:
          case dataset.ATTRIBUTE_CATEGORY:
            break;
          case dataset.ATTRIBUTE_OS:
          case dataset.ATTRIBUTE_VERSION:
          case dataset.ATTRIBUTE_VENDOR:
            if (! entry[attr]) return;
            break;
          default:
            throw 'unknown attribute: ' + attr;
          }

          expect(result[attr]).to.equal(entry[attr]);
        });
      });
    });
  });
});
