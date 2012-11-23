var expect = require('chai').expect;

var dataset = require('../lib/dataset');

describe('woothee dataset', function(){
  it('contains constants', function(){
    expect(dataset.ATTRIBUTE_NAME).to.be.a('string');
    expect(dataset.ATTRIBUTE_NAME).to.equal('name');
  });

  it('contains list of attributes', function(){
    expect(dataset.ATTRIBUTE_LIST).to.eql([
      dataset.ATTRIBUTE_NAME, dataset.ATTRIBUTE_CATEGORY, dataset.ATTRIBUTE_OS,
      dataset.ATTRIBUTE_VENDOR, dataset.ATTRIBUTE_VERSION
    ]);
  });

  it('contains list of categories', function(){
    expect(dataset.CATEGORY_LIST).to.eql([
      dataset.CATEGORY_PC, dataset.CATEGORY_SMARTPHONE, dataset.CATEGORY_MOBILEPHONE,
      dataset.CATEGORY_CRAWLER, dataset.CATEGORY_APPLIANCE, dataset.CATEGORY_MISC,
      dataset.VALUE_UNKNOWN
    ]);
  });

  it('contains certain dataset', function(){
    expect(dataset.get('GoogleBot').name).to.be.equal('Googlebot');
  });
});
