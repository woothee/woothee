/* HEADER BEGIN */
var dataset = require('./dataset'),
    browser = require('./browser'),
    os = require('./os'),
    mobilephone = require('./mobilephone'),
    crawler = require('./crawler'),
    appliance = require('./appliance'),
    misc = require('./misc');
/* HEADER END */

var parse = exports.parse = function(userAgent) {
  return fillResult(execParse(userAgent));
};

var isCrawler = exports.isCrawler = function(userAgent) {
  return false;
};

function execParse(userAgent) {
  var result = {};

  if (userAgent.length < 1 || userAgent === '-')
    return result;

  if (tryCrawler(userAgent, result))
    return result;

  if (tryBrowser(userAgent, result)) {
    if (tryOS(userAgent, result))
      return result;
    else
      return result;
  }

  if (tryMobilePhone(userAgent, result))
    return result;

  if (tryAppliance(userAgent, result))
    return result;

  if (tryMisc(userAgent, result))
    return result;

  // browser unknown, check os only
  if (tryOS(userAgent, result))
    return result;

  if (tryRareCases(userAgent, result))
    return result;

  return result;
};

function tryCrawler(userAgent, result) {
  if (crawler.challengeGoogle(userAgent, result))
    return true;

  if (crawler.challengeCrawlers(userAgent, result))
    return true;

  return false;
}

function tryBrowser(userAgent, result) {
  if (browser.challengeMSIE(userAgent, result))
    return true;

  if (browser.challengeSafariChrome(userAgent, result))
    return true;

  if (browser.challengeFirefox(userAgent, result))
    return true;

  if (browser.challengeOpera(userAgent, result))
    return true;

  return false;
}

function tryOS(userAgent, result) {
  if (os.challengeWindows(userAgent, result))
    return true;

  // OSX PC and iOS devices (strict check)
  if (os.challengeOSX(userAgent, result))
    return true;

  // Linux PC and Android
  if (os.challengeLinux(userAgent, result))
    return true;

  // all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
  if (os.challengeSmartPhone(userAgent, result))
    return true;

  // mobile phones like KDDI-.*
  if (os.challengeMobilePhone(userAgent, result))
    return true;

  // Nintendo DSi/Wii with Opera
  if (os.challengeAppliance(userAgent, result))
    return true;

  if (os.challengeMisc(userAgent, result))
    return true;

  return false;
}

function tryMobilePhone(userAgent, result) {
  if (mobilephone.challengeDocomo(userAgent, result))
    return true;

  if (mobilephone.challengeAu(userAgent, result))
    return true;

  if (mobilephone.challengeSoftbank(userAgent, result))
    return true;

  if (mobilephone.challengeWillcom(userAgent, result))
    return true;

  if (mobilephone.challengeMisc(userAgent, result))
    return true;

  return false;
}

function tryAppliance(userAgent, result) {
  if (appliance.challengePlaystation(userAgent, result))
    return true;

  if (appliance.challengeNintendo(userAgent, result))
    return true;

  if (appliance.challengeDigitalTV(userAgent, result))
    return true;

  return false;
}

function tryMisc(userAgent, result) {
  if (misc.challengeDesktopTools(userAgent, result))
    return true;

  return false;
}

function tryRareCases(userAgent, result) {
  if (misc.challengeSmartPhonePatterns(userAgent, result))
    return true;

  if (browser.challengeSleipnir(userAgent, result))
    return true;

  if (misc.challengeHTTPLibrary(userAgent, result))
    return true;

  if (misc.challengeMaybeRSSReader(userAgent, result))
    return true;

  if (crawler.challengeMaybeCrawler(userAgent, result))
    return true;

  return false;
}

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