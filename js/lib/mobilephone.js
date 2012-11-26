/* HEADER BEGIN */
var util = require('./util'),
    updateMap = util.updateMap,
    updateVersion = util.updateVersion,
    updateCategory = util.updateCategory,
    updateOs = util.updateOs,
    dataset = require('./dataset');
/* HEADER END */

var docomoPattern = /DoCoMo\/[.0-9]+[ \/]([^- \/;()"']+)/;
var fomaPattern = /\(([^;)]+);FOMA;/;
var challengeDocomo = exports.challengeDocomo = function(ua, result) {
  if (ua.indexOf('DoCoMo') < 0 && ua.indexOf(';FOMA;') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match;
  if ((match = docomoPattern.exec(ua))) {
    version = match[1];
  } else if ((match = fomaPattern.exec(ua))) {
    version = match[1];
  }
  updateMap(result, dataset.get('docomo'));
  updateVersion(result, version);
  return true;
};

var kddiPattern = /KDDI-([^- \/;()"']+)/;
var challengeAu = exports.challengeAu = function(ua, result) {
  if (ua.indexOf('KDDI-') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = kddiPattern.exec(ua);
  if (match)
    version = match[1];
  updateMap(result, dataset.get('au'));
  updateVersion(result, version);
  return true;
};

var softbankPattern = /(?:SoftBank|Vodafone|J-PHONE)\/[.0-9]+\/([^ \/;()]+)/;
var challengeSoftbank = exports.challengeSoftbank = function(ua, result) {
  if (ua.indexOf('SoftBank') < 0 && ua.indexOf('Vodafone') < 0 && ua.indexOf('J-PHONE') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = softbankPattern.exec(ua);
  if (match)
    version = match[1];
  updateMap(result, dataset.get('SoftBank'));
  updateVersion(result, version);
  return true;
};

var willcomPattern = /(?:WILLCOM|DDIPOCKET);[^\/]+\/([^ \/;()]+)/;
var challengeWillcom = exports.challengeWillcom = function(ua, result) {
  if (ua.indexOf('WILLCOM') < 0 && ua.indexOf('DDIPOCKET') < 0)
    return false;

  var version = dataset.VALUE_UNKNOWN;
  var match = willcomPattern.exec(ua);
  if (match)
    version = match[1];
  updateMap(result, dataset.get('willcom'));
  updateVersion(result, version);
  return true;
};

var challengeMisc = exports.challengeMisc = function(ua, result) {
  var match;
  if (ua.indexOf('jig browser') >= 0) {
    updateMap(result, dataset.get('jig'));
    if ((match = /jig browser[^;]+; ([^);]+)/.exec(ua))) {
      updateVersion(result, match[1]);
    }
    return true;
  }
  if (ua.indexOf('emobile/') >= 0 || ua.indexOf('OpenBrowser') >= 0 || ua.indexOf('Browser/Obigo-Browser') >= 0) {
    updateMap(result, dataset.get('emobile'));
    return true;
  }
  if (ua.indexOf('SymbianOS') >= 0) {
    updateMap(result, dataset.get('SymbianOS'));
    return true;
  }
  if (ua.indexOf('Hatena-Mobile-Gateway/') >= 0) {
    updateMap(result, dataset.get('MobileTranscoder'));
    updateVersion(result, 'Hatena');
    return true;
  }
  if (ua.indexOf('livedoor-Mobile-Gateway/') >= 0) {
    updateMap(result, dataset.get('MobileTranscoder'));
    updateVersion(result, 'livedoor');
    return true;
  }
  return false;
};
