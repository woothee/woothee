var dataset = require('./dataset'),
    browser = require('./browser')/*,
    os = require('./os')*//*,
    mobilephone = require('./mobilephone'),
    crawler = require('./crawler'),
    appliance = require('./appliance'),
    misc = require('./misc')*/;

var parse = exports.parse = function(userAgent) {
  return fillResult(execParse(userAgent));
};

var isCrawler = exports.isCrawler = function(userAgent) {
  return false;
};

function execParse(userAgent) {
  return {};
};

var filled = {};
filled[dataset.ATTRIBUTE_NAME] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_CATEGORY] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_OS] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_VERSION] = dataset.VALUE_UNKNOWN;
filled[dataset.ATTRIBUTE_VENDOR] = dataset.VALUE_UNKNOWN;

function fillResult(result) {
  if (! result[dataset.ATTRIBUTE_NAME])
    result[dataset.ATTRIBUTE_NAME] = dataset.VALUE_UNKNOWN;
  if (! result[dataset.ATTRIBUTE_CATEGORY])
    result[dataset.ATTRIBUTE_CATEGORY] = dataset.VALUE_UNKNOWN;
  if (! result[dataset.ATTRIBUTE_OS])
    result[dataset.ATTRIBUTE_OS] = dataset.VALUE_UNKNOWN;
  if (! result[dataset.ATTRIBUTE_VERSION])
    result[dataset.ATTRIBUTE_VERSION] = dataset.VALUE_UNKNOWN;
  if (! result[dataset.ATTRIBUTE_VENDOR])
    result[dataset.ATTRIBUTE_VENDOR] = dataset.VALUE_UNKNOWN;
  return result;
};