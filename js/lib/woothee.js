var dataset = require('./dataset'),
    browser = require('./browser'),
    os = require('./os'),
    mobilephone = require('./mobilephone'),
    crawler = require('./crawler'),
    appliance = require('./appliance'),
    misc = require('./misc');

var parse = exports.parse = function(userAgent) {
  return fillResult(execParse(userAgent));
};

var isCrawler = exports.isCrawler = function(userAgent) {
  
};

function execParse(userAgent) {
};

var filled = {};
filled[dataset.ATTRIBUTE_NAME] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_CATEGORY] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_OS] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_VERSION] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_VENDOR] = dataset.VALUE_UNKNOWN;

function fillResult(result) {
  if (! dataset.ATTRIBUTE_NAME in result)     result[dataset.ATTRIBUTE_NAME] = dataset.VALUE_UNKNOWN;
  if (! dataset.ATTRIBUTE_CATEGORY in result) result[dataset.ATTRIBUTE_CATEGORY] = dataset.VALUE_UNKNOWN;
  if (! dataset.ATTRIBUTE_OS in result)       result[dataset.ATTRIBUTE_OS] = dataset.VALUE_UNKNOWN;
  if (! dataset.ATTRIBUTE_VERSION in result)  result[dataset.ATTRIBUTE_VERSION] = dataset.VALUE_UNKNOWN;
  if (! dataset.ATTRIBUTE_VENDOR in result)   result[dataset.ATTRIBUTE_VENDOR] = dataset.VALUE_UNKNOWN;
  return result;
};