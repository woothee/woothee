/* HEADER BEGIN */
var util = require('./util'),
    updateMap = util.updateMap,
    updateVersion = util.updateVersion,
    updateCategory = util.updateCategory,
    updateOs = util.updateOs,
    dataset = require('./dataset');
/* HEADER END */

var challengeDesktopTools = exports.challengeDesktopTools = function(ua, result){
  var data = null;
  if (ua.indexOf('AppleSyndication/') >= 0) data = dataset.get('SafariRSSReader');
  else if (ua.indexOf('compatible; Google Desktop/') >= 0) data = dataset.get('GoogleDesktop');
  else if (ua.indexOf('Windows-RSS-Platform') >= 0) data = dataset.get('WindowsRSSReader');

  if (!data)
    return false;

  updateMap(result, data);
  return true;
};

var challengeSmartPhonePatterns = exports.challengeSmartPhonePatterns = function(ua, result){
  var data;
  if (ua.indexOf('CFNetwork/') >= 0) {
    data = dataset.get('iOS');
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_NAME]);
    return true;
  }

  return false;
};

var challengeHTTPLibrary = exports.challengeHTTPLibrary = function(ua, result){
  var data,version;
  if (/^(?:Apache-HttpClient\/|Jakarta Commons-HttpClient\/|Java\/)/.exec(ua) || /[- ]HttpClient(\/|$)/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'Java';
  } else if (ua.indexOf('Java(TM) 2 Runtime Environment,') >= 0) {
    data = dataset.get('HTTPLibrary'); version = 'Java';
  } else if (/^Wget/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'wget';
  } else if (/^(?:libwww-perl|WWW-Mechanize|LWP::Simple|LWP |lwp-trivial)/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'perl';
  } else if (/^(?:Ruby|feedzirra|Typhoeus)/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'ruby';
  } else if (/^(?:Python-urllib\/|Twisted )/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'python';
  } else if (/^(:?PHP|WordPress|CakePHP|PukiWiki|PECL::HTTP)(?:\/| |$)/.exec(ua) || /(?:PEAR |)HTTP_Request(?: class|2)/.exec(ua)) {
    data = dataset.get('HTTPLibrary'); version = 'php';
  } else if (ua.indexOf('PEAR HTTP_Request class;') >= 0) {
    data = dataset.get('HTTPLibrary'); version = 'php';
  }

  if (! data)
    return false;

  updateMap(result, data);
  updateVersion(result, version);
  return true;
};

var challengeMaybeRSSReader = exports.challengeMaybeRSSReader = function(ua, result){
  var data = null;
  if (/rss(?:reader|bar|[-_ \/;()]|[ +]*\/)/i.exec(ua) || /headline-reader/i.exec(ua)) {
    data = dataset.get('VariousRSSReader');
  }
  else {
    if (ua.indexOf('cococ/') >= 0)
      data = dataset.get('VariousRSSReader');
  }

  if (! data)
    return false;

  updateMap(result, data);
  return true;
};
