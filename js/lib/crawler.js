/* HEADER BEGIN */
var util = require('./util'),
    updateMap = util.updateMap,
    updateVersion = util.updateVersion,
    updateCategory = util.updateCategory,
    updateOs = util.updateOs,
    dataset = require('./dataset');
/* HEADER END */

var challengeGoogle = exports.challengeGoogle = function(ua, result) {
  if (ua.indexOf('Google') < 0)
    return false;

  if (ua.indexOf('compatible; Googlebot') >= 0) {
    if (ua.indexOf('compatible; Googlebot-Mobile') >= 0) {
      updateMap(result, dataset.get('GoogleBotMobile'));
      return true;
    } else {
      updateMap(result, dataset.get('GoogleBot'));
      return true;
    }
  }
  if (ua.indexOf('Googlebot-Image/') >= 0) {
    updateMap(result, dataset.get('GoogleBot'));
    return true;
  }
  if (ua.indexOf('Mediapartners-Google') >= 0) {
    if (ua.indexOf('compatible; Mediapartners-Google') >= 0 || ua === 'Mediapartners-Google') {
      updateMap(result, dataset.get('GoogleMediaPartners'));
      return true;
    }
  }
  if (ua.indexOf('Feedfetcher-Google;') >= 0) {
    updateMap(result, dataset.get('GoogleFeedFetcher'));
    return true;
  }
  if (ua.indexOf('AppEngine-Google') >= 0) {
    updateMap(result, dataset.get('GoogleAppEngine'));
    return true;
  }
  if (ua.indexOf('Google Web Preview') >= 0) {
    updateMap(result, dataset.get('GoogleWebPreview'));
    return true;
  }

  return false;
};

var challengeCrawlers = exports.challengeCrawlers = function(ua, result) {
  if (ua.indexOf('Yahoo') >= 0
      || ua.indexOf('help.yahoo.co.jp/help/jp/') >= 0
      || ua.indexOf('listing.yahoo.co.jp/support/faq/') >= 0) {
    if (ua.indexOf('compatible; Yahoo! Slurp') >= 0) {
      updateMap(result, dataset.get('YahooSlurp'));
      return true;
    }
    if (ua.indexOf('YahooFeedSeekerJp') >= 0 || ua.indexOf('YahooFeedSeekerBetaJp') >= 0) {
      updateMap(result, dataset.get('YahooJP'));
      return true;
    }
    if (ua.indexOf('crawler (http://listing.yahoo.co.jp/support/faq/') >= 0
        || ua.indexOf('crawler (http://help.yahoo.co.jp/help/jp/') >= 0) {
      updateMap(result, dataset.get('YahooJP'));
      return true;
    }
    if (ua.indexOf('Yahoo Pipes') >= 0) {
      updateMap(result, dataset.get('YahooPipes'));
      return true;
    }
  }
  if (ua.indexOf('msnbot') >= 0) {
    updateMap(result, dataset.get('msnbot'));
    return true;
  }
  if (ua.indexOf('bingbot') >= 0) {
    if (ua.indexOf('compatible; bingbot') >= 0) {
      updateMap(result, dataset.get('bingbot'));
      return true;
    }
  }
  if (ua.indexOf('Baidu') >= 0) {
    if (ua.indexOf('compatible; Baiduspider') >= 0 ||
        ua.indexOf('Baiduspider+') >= 0 ||
        ua.indexOf('Baiduspider-image+') >= 0) {
      updateMap(result, dataset.get('Baiduspider'));
      return true;
    }
  }
  if (ua.indexOf('Yeti') >= 0) {
    if (ua.indexOf('http://help.naver.com/robots') >= 0) {
      updateMap(result, dataset.get('Yeti'));
      return true;
    }
  }
  if (ua.indexOf('FeedBurner/') >= 0) {
    updateMap(result, dataset.get('FeedBurner'));
    return true;
  }
  if (ua.indexOf('facebookexternalhit') >= 0) {
    updateMap(result, dataset.get('facebook'));
    return true;
  }
  if (ua.indexOf('ichiro') >= 0) {
    if (ua.indexOf('http://help.goo.ne.jp/door/crawler.html') >= 0 ||
        ua.indexOf('compatible; ichiro/mobile goo;') >= 0) {
      updateMap(result, dataset.get('goo'));
      return true;
    }
  }
  if (ua.indexOf('gooblogsearch/') >= 0) {
    updateMap(result, dataset.get('goo'));
    return true;
  }
  if (ua.indexOf('Apple-PubSub') >= 0) {
    updateMap(result, dataset.get('ApplePubSub'));
    return true;
  }
  if (ua.indexOf('(www.radian6.com/crawler)') >= 0) {
    updateMap(result, dataset.get('radian6'));
    return true;
  }
  if (ua.indexOf('Genieo/') >= 0) {
    updateMap(result, dataset.get('Genieo'));
    return true;
  }
  if (ua.indexOf('labs.topsy.com/butterfly/') >= 0) {
    updateMap(result, dataset.get('topsyButterfly'));
    return true;
  }
  if (ua.indexOf('rogerbot/1.0 (http://www.seomoz.org/dp/rogerbot') >= 0) {
    updateMap(result, dataset.get('rogerbot'));
    return true;
  }
  if (ua.indexOf('compatible; AhrefsBot/') >= 0) {
    updateMap(result, dataset.get('AhrefsBot'));
    return true;
  }
  if (ua.indexOf('livedoor FeedFetcher') >= 0 || ua.indexOf('Fastladder FeedFetcher') >= 0) {
    updateMap(result, dataset.get('livedoorFeedFetcher'));
    return true;
  }
  if (ua.indexOf('Hatena ') >= 0) {
    if (ua.indexOf('Hatena Antenna') >= 0 ||
        ua.indexOf('Hatena Pagetitle Agent') >= 0 ||
        ua.indexOf('Hatena Diary RSS') >= 0) {
      updateMap(result, dataset.get('Hatena'));
      return true;
    }
  }
  if (ua.indexOf('mixi-check') >= 0 ||
      ua.indexOf('mixi-crawler') >= 0 ||
      ua.indexOf('mixi-news-crawler') >= 0) {
    updateMap(result, dataset.get('mixi'));
    return true;
  }
  if (ua.indexOf('Indy Library') >= 0) {
    if (ua.indexOf('compatible; Indy Library') >= 0) {
      updateMap(result, dataset.get('IndyLibrary'));
      return true;
    }
  }

  return false;
};

var challengeMaybeCrawler = exports.challengeMaybeCrawler = function(ua, result) {
  if (/(bot|crawler|spider)(?:[-_ .\/;@()]|$)/i.exec(ua)) {
    updateMap(result, dataset.get('VariousCrawler'));
    return true;
  }
  if (/(?:Rome Client |UnwindFetchor\/|ia_archiver |Summify |PostRank\/)/.exec(ua) ||
      ua.indexOf('ASP-Ranker Feed Crawler') >= 0) {
    updateMap(result, dataset.get('VariousCrawler'));
    return true;
  }
  if (/(feed|web) ?parser/i.exec(ua)) {
    updateMap(result, dataset.get('VariousCrawler'));
    return true;
  }
  if (/watch ?dog/i.exec(ua)) {
    updateMap(result, dataset.get('VariousCrawler'));
    return true;
  }
  return false;
};
