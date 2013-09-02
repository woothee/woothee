/* HEADER BEGIN */
var util = require('./util'),
    updateMap = util.updateMap,
    updateVersion = util.updateVersion,
    updateCategory = util.updateCategory,
    updateOs = util.updateOs,
    dataset = require('./dataset');
/* HEADER END */

var msiePattern = /MSIE ([.0-9]+);/;
var tridentPattern = /Trident\/[.0-9]+; rv ([.0-9]+)/;
var challengeMSIE = exports.challengeMSIE = function(ua, result) {
  if (ua.indexOf('compatible; MSIE') < 0 && ua.indexOf('Trident/') < 0)
    return false;

  var version;
  var match;
  if ((match = msiePattern.exec(ua)) || (match = tridentPattern.exec(ua)))
    version = match[1];
  else
    version = dataset.VALUE_UNKNOWN;
  updateMap(result, dataset.get('MSIE'));
  updateVersion(result, version);
  return true;
};

var chromePattern = /(?:Chrome|CrMo|CriOS)\/([.0-9]+)/;
var safariPattern = /Version\/([.0-9]+)/;
var challengeSafariChrome = exports.challengeSafariChrome = function(ua, result) {
  if (ua.indexOf('Safari/') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;

  var match;
  if ((match = chromePattern.exec(ua))) {
    // Chrome
    version = match[1];
    updateMap(result, dataset.get('Chrome'));
    updateVersion(result, version);
    return true;
  }

  if ((match = safariPattern.exec(ua))) {
    version = match[1];
  }

  updateMap(result, dataset.get('Safari'));
  updateVersion(result, version);
  return true;
};

var firefoxPattern = /Firefox\/([.0-9]+)/;
var challengeFirefox = exports.challengeFirefox = function(ua, result) {
  if (ua.indexOf('Firefox/') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = firefoxPattern.exec(ua);
  if (match)
    version = match[1];
  updateMap(result, dataset.get('Firefox'));
  updateVersion(result, version);
  return true;
};

var operaPattern1 = /Version\/([.0-9]+)/;
var operaPattern2 = /Opera[\/ ]([.0-9]+)/;
var challengeOpera = exports.challengeOpera = function(ua, result) {
  if (ua.indexOf('Opera') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = operaPattern1.exec(ua);
  if (match) {
    version = match[1];
  } else {
    match = operaPattern2.exec(ua);
    if (match)
      version = match[1];
  }
  updateMap(result, dataset.get('Opera'));
  updateVersion(result, version);
  return true;
};

var sleipnirPattern = /Sleipnir\/([.0-9]+)/;
var challengeSleipnir = exports.challengeSleipnir = function(ua, result) {
  if (ua.indexOf('Sleipnir/') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = sleipnirPattern.exec(ua);
  if (match)
    version = match[1];
  updateMap(result, dataset.get('Sleipnir'));
  updateVersion(result, version);

  /*
   Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
   Sleipnir is IE component browser, so for Windows only.
   */
  var win = dataset.get('Win');
  updateCategory(result, win[dataset.KEY_CATEGORY]);
  updateOs(result, win[dataset.KEY_NAME]);

  return true;
};
