var KEY_LABEL = exports.KEY_LABEL = 'label',
    KEY_NAME = exports.KEY_NAME = 'name',
    KEY_TYPE = exports.KEY_TYPE = 'type',
    KEY_CATEGORY = exports.KEY_CATEGORY = 'category',
    KEY_OS = exports.KEY_OS = 'os',
    KEY_VENDOR = exports.KEY_VENDOR = 'vendor',
    KEY_VERSION = exports.KEY_VERSION = 'version';

var TYPE_BROWSER = 'browser',
    TYPE_OS = 'os',
    TYPE_FULL = 'full';

var CATEGORY_PC = exports.CATEGORY_PC = 'pc',
    CATEGORY_SMARTPHONE = exports.CATEGORY_SMARTPHONE = 'smartphone',
    CATEGORY_MOBILEPHONE = exports.CATEGORY_MOBILEPHONE = 'mobilephone',
    CATEGORY_CRAWLER = exports.CATEGORY_CRAWLER = 'crawler',
    CATEGORY_APPLIANCE = exports.CATEGORY_APPLIANCE = 'appliance',
    CATEGORY_MISC = exports.CATEGORY_MISC = 'misc';

var ATTRIBUTE_NAME = exports.ATTRIBUTE_NAME = 'name',
    ATTRIBUTE_CATEGORY = exports.ATTRIBUTE_CATEGORY = 'category',
    ATTRIBUTE_OS = exports.ATTRIBUTE_OS = 'os',
    ATTRIBUTE_VENDOR = exports.ATTRIBUTE_VENDOR = 'vendor',
    ATTRIBUTE_VERSION = exports.ATTRIBUTE_VERSION = 'version';

var VALUE_UNKNOWN = 'UNKNOWN';

var CATEGORY_LIST = exports.CATEGORY_LIST = [
  CATEGORY_PC, CATEGORY_SMARTPHONE, CATEGORY_MOBILEPHONE,
  CATEGORY_CRAWLER, CATEGORY_APPLIANCE, CATEGORY_MISC, VALUE_UNKNOWN
];
var ATTRIBUTE_LIST = [ATTRIBUTE_NAME, ATTRIBUTE_CATEGORY, ATTRIBUTE_OS, ATTRIBUTE_VENDOR, ATTRIBUTE_VERSION];

var DATASET = {};
/* GENERATED from dataset.yaml at ....... */
var obj;
obj = {label:'MSIE', name:'Internet Explorer', type:'Browser'};
obj['vendor'] = 'Microsoft';
DATASET[obj.label] = obj;
// obj = ...
/* END */

var get = exports.get = function(label) {
  return DATASET[label];
};
