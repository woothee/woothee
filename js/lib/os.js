/* HEADER BEGIN */
var util = require('./util'),
    updateMap = util.updateMap,
    updateVersion = util.updateVersion,
    updateCategory = util.updateCategory,
    updateOs = util.updateOs,
    dataset = require('./dataset');
/* HEADER END */

var windowsPattern = /Windows ([ .a-zA-Z0-9]+)[;\\)]/;
var windowsPhonePattern = /^Phone OS/;
var challengeWindows = exports.challengeWindows = function(ua, result) {
  if (ua.indexOf('Windows') < 0)
    return false;

  var data = dataset.get('Win');
  var match = windowsPattern.exec(ua);
  if (!match) {
    // Windows, but version unknown
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_NAME]);
    return true;
  }
  var version = match[1];
  if (version === 'NT 6.3') data = dataset.get('Win8.1'); 
  else if (version === 'NT 6.2') data = dataset.get('Win8'); // "NT 6.2; ARM;" means Windows RT, oh....
  else if (version === 'NT 6.1') data = dataset.get('Win7');
  else if (version === 'NT 6.0') data = dataset.get('WinVista');
  else if (version === 'NT 5.1') data = dataset.get('WinXP');
  else if (windowsPhonePattern.exec(version)) data = dataset.get('WinPhone');
  else if (version === 'NT 5.0') data = dataset.get('Win2000');
  else if (version === 'NT 4.0') data = dataset.get('WinNT4');
  else if (version === '98') data = dataset.get('Win98'); // wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
  else if (version === '95') data = dataset.get('Win95');
  else if (version === 'CE') data = dataset.get('WinCE');
  /*
  else
    // windows unknown
   */
  updateCategory(result, data[dataset.KEY_CATEGORY]);
  updateOs(result, data[dataset.KEY_NAME]);
  return true;
};

var challengeOSX = exports.challengeOSX = function(ua, result) {
  if (ua.indexOf('Mac OS X') < 0)
    return false;

  var data = dataset.get('OSX');
  if (ua.indexOf('like Mac OS X') >= 0) {
    if (ua.indexOf('iPhone;') >= 0) data = dataset.get('iPhone');
    else if (ua.indexOf('iPad;') >= 0) data = dataset.get('iPad');
    else if (ua.indexOf('iPod;') >= 0) data = dataset.get('iPod');
  }
  updateCategory(result, data[dataset.KEY_CATEGORY]);
  updateOs(result, data[dataset.KEY_NAME]);
  return true;
};

var challengeLinux = exports.challengeLinux = function(ua, result) {
  if (ua.indexOf('Linux') < 0)
    return false;

  var data = dataset.get('Linux');
  if (ua.indexOf('Android') >= 0)
    data = dataset.get('Android');
  updateCategory(result, data[dataset.KEY_CATEGORY]);
  updateOs(result, data[dataset.KEY_NAME]);
  return true;
};

var challengeSmartPhone = exports.challengeSmartPhone = function(ua, result) {
  var data = null;
  if (ua.indexOf('iPhone') >= 0) data = dataset.get('iPhone');
  else if (ua.indexOf('iPad') >= 0) data = dataset.get('iPad');
  else if (ua.indexOf('iPod') >= 0) data = dataset.get('iPod');
  else if (ua.indexOf('Android') >= 0) data = dataset.get('Android');
  else if (ua.indexOf('CFNetwork') >= 0) data = dataset.get('iOS');
  else if (ua.indexOf('BlackBerry') >= 0) data = dataset.get('BlackBerry');

  if (result[dataset.KEY_NAME] && result[dataset.KEY_NAME] === dataset.get('Firefox')[dataset.KEY_NAME]) {
    // Firefox OS specific pattern
    // http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
    if (/^Mozilla\/[.0-9]+ \(Mobile;(.*;)? rv:[.0-9]+\) Gecko\/[.0-9]+ Firefox\/[.0-9]+$/.exec(ua)) {
      data = dataset.get('FirefoxOS');
    }
  }

  if (!data)
    return false;

  updateCategory(result, data[dataset.KEY_CATEGORY]);
  updateOs(result, data[dataset.KEY_NAME]);
  return true;
};

var challengeMobilePhone = exports.challengeMobilePhone = function(ua, result) {
  var data,match;
  if (ua.indexOf('KDDI-') >= 0) {
    if ((match = /KDDI-([^- \/;()"']+)/.exec(ua))) {
      var term = match[1];
      data = dataset.get('au');
      updateCategory(result, data[dataset.KEY_CATEGORY]);
      updateOs(result, data[dataset.KEY_OS]);
      updateVersion(result, term);
      return true;
    }
  }
  if (ua.indexOf('WILLCOM') >= 0 || ua.indexOf('DDIPOCKET') >= 0) {
    if ((match = /(?:WILLCOM|DDIPOCKET);[^\/]+\/([^ \/;()]+)/.exec(ua))) {
      term = match[1];
      data = dataset.get('willcom');
      updateCategory(result, data[dataset.KEY_CATEGORY]);
      updateOs(result, data[dataset.KEY_OS]);
      updateVersion(result, term);
      return true;
    }
  }
  if (ua.indexOf('SymbianOS') >= 0) {
    data = dataset.get('SymbianOS');
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_OS]);
    return true;
  }
  if (ua.indexOf('Google Wireless Transcoder') >= 0) {
    updateMap(result, dataset.get('MobileTranscoder'));
    updateVersion(result, 'Google');
    return true;
  }
  if (ua.indexOf('Naver Transcoder') >= 0) {
    updateMap(result, dataset.get('MobileTranscoder'));
    updateVersion(result, 'Naver');
    return true;
  }

  return false;
};

var challengeAppliance = exports.challengeAppliance = function(ua, result) {
  var data;
  if (ua.indexOf('Nintendo DSi;') >= 0) {
    data = dataset.get('NintendoDSi');
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_OS]);
    return true;
  }
  if (ua.indexOf('Nintendo Wii;') >= 0) {
    data = dataset.get('NintendoWii');
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_OS]);
    return true;
  }
  return false;
};

var challengeMisc = exports.challengeMisc = function(ua, result) {
  var data;
  if (ua.indexOf('(Win98;') >= 0) data = dataset.get('Win98');
  else if (ua.indexOf('Macintosh; U; PPC;') >= 0) data = dataset.get('MacOS');
  else if (ua.indexOf('Mac_PowerPC') >= 0) data = dataset.get('MacOS');
  else if (ua.indexOf('X11; FreeBSD ') >= 0) data = dataset.get('BSD');

  if (data) {
    updateCategory(result, data[dataset.KEY_CATEGORY]);
    updateOs(result, data[dataset.KEY_NAME]);
    return true;
  }

  return false;
};
