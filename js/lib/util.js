/* HEADER BEGIN */
var dataset = require('./dataset');
/* HEADER END */

var updateMap = exports.updateMap = function(target, source) {
  for (var key in source) {
    if (key === dataset.KEY_LABEL || key === dataset.KEY_TYPE)
      continue;
    if (source[key] && source[key].length > 0)
      target[key] = source[key];
  }
};

var updateCategory = exports.updateCategory = function(target, category) {
  target[dataset.ATTRIBUTE_CATEGORY] = category;
};

var updateVersion = exports.updateVersion = function(target, version) {
  target[dataset.ATTRIBUTE_VERSION] = version;
};

var updateOs = exports.updateOs = function(target, os) {
  target[dataset.ATTRIBUTE_OS] = os;
};
