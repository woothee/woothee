# -*- coding: utf-8 -*-

import re
from . import dataset
from . import util

def challenge_google(ua, result):
  if 'Google' not in ua:
    return False
  
  if 'compatible; Googlebot' in ua:
    if 'compatible; Googlebot-Mobile' in ua:
      util.update_map(result, dataset.get('GoogleBotMobile'))
    else:
      util.update_map(result, dataset.get('GoogleBot'))
    return True
  
  if 'Googlebot-Image/' in ua:
    util.update_map(result, dataset.get('GoogleBot'))
    return True
  
  if 'Mediapartners-Google' in ua:
    if 'compatible; Mediapartners-Google' in ua or ua == 'Mediapartners-Google':
      util.update_map(result, dataset.get('GoogleMediaPartners'))
      return True
  
  if 'Feedfetcher-Google;' in ua:
    util.update_map(result, dataset.get('GoogleFeedFetcher'))
    return True
  
  if 'AppEngine-Google' in ua:
    util.update_map(result, dataset.get('GoogleAppEngine'))
    return True
  
  if 'Google Web Preview' in ua:
    util.update_map(result, dataset.get('GoogleWebPreview'))
    return True
  
  return False

def challenge_crawlers(ua, result):
  if 'Yahoo' in ua or 'help.yahoo.co.jp/help/jp/' in ua or 'listing.yahoo.co.jp/support/faq/' in ua:
    if 'compatible; Yahoo! Slurp' in ua:
      util.update_map(result, dataset.get('YahooSlurp'))
      return True
    
    if 'YahooFeedSeekerJp' in ua or 'YahooFeedSeekerBetaJp' in ua:
      util.update_map(result, dataset.get('YahooJP'))
      return True
    
    if 'crawler (http://listing.yahoo.co.jp/support/faq/' in ua or 'crawler (http://help.yahoo.co.jp/help/jp/' in ua:
      util.update_map(result, dataset.get('YahooJP'))
      return True
    
    if 'Yahoo Pipes' in ua:
      util.update_map(result, dataset.get('YahooPipes'))
      return True
  
  if 'msnbot' in ua:
    util.update_map(result, dataset.get('msnbot'))
    return True
  
  if 'bingbot' in ua:
    if 'compatible; bingbot' in ua:
      util.update_map(result, dataset.get('bingbot'))
      return True
  
  if 'Baidu' in ua:
    if 'compatible; Baiduspider' in ua or 'Baiduspider+' in ua or 'Baiduspider-image+' in ua:
      util.update_map(result, dataset.get('Baiduspider'))
      return True
    
  if 'Yeti' in ua:
    if 'http://help.naver.com/robots' in ua:
      util.update_map(result, dataset.get('Yeti'))
      return True
  
  if 'FeedBurner/' in ua:
    util.update_map(result, dataset.get('FeedBurner'))
    return True
  
  if 'facebookexternalhit' in ua:
    util.update_map(result, dataset.get('facebook'))
    return True
  
  if 'ichiro' in ua:
    if 'http://help.goo.ne.jp/door/crawler.html' in ua or 'compatible; ichiro/mobile goo;' in ua:
      util.update_map(result, dataset.get('goo'))
      return True
  if 'gooblogsearch/' in ua:
    util.update_map(result, dataset.get('goo'))
    return True
  
  if 'Apple-PubSub' in ua:
    util.update_map(result, dataset.get('ApplePubSub'))
    return True

  if '(www.radian6.com/crawler)' in ua:
    util.update_map(result, dataset.get('radian6'))
    return True

  if 'Genieo/' in ua:
    util.update_map(result, dataset.get('Genieo'))
    return True

  if 'labs.topsy.com/butterfly/' in ua:
    util.update_map(result, dataset.get('topsyButterfly'))
    return True

  if 'rogerbot/1.0 (http://www.seomoz.org/dp/rogerbot' in ua:
    util.update_map(result, dataset.get('rogerbot'))
    return True

  if 'compatible; AhrefsBot/' in ua:
    util.update_map(result, dataset.get('AhrefsBot'))
    return True
  
  if 'livedoor FeedFetcher' in ua or 'Fastladder FeedFetcher' in ua:
    util.update_map(result, dataset.get('livedoorFeedFetcher'))
    return True
  
  if 'Hatena ' in ua:
    if 'Hatena Antenna' in ua or 'Hatena Pagetitle Agent' in ua or 'Hatena Diary RSS' in ua:
      util.update_map(result, dataset.get('Hatena'))
      return True
  
  if 'mixi-check' in ua or 'mixi-crawler' in ua or 'mixi-news-crawler' in ua:
    util.update_map(result, dataset.get('mixi'))
    return True
  
  if 'Indy Library' in ua:
    if 'compatible; Indy Library' in ua:
      util.update_map(result, dataset.get('IndyLibrary'))
      return True
  
  return False

def challenge_maybe_crawler(ua, result):
  if re.search('(bot|crawler|spider)(?:[-_ ./;@()]|$)', ua, re.I):
    util.update_map(result, dataset.get('VariousCrawler'))
    return True
  
  if re.search('(?:Rome Client |UnwindFetchor/|ia_archiver |Summify |PostRank/)', ua) or 'ASP-Ranker Feed Crawler' in ua:
    util.update_map(result, dataset.get('VariousCrawler'))
    return True
  
  if re.search('(feed|web) ?parser', ua, re.I):
    util.update_map(result, dataset.get('VariousCrawler'))
    return True
  
  if re.search('watch ?dog', ua, re.I):
    util.update_map(result, dataset.get('VariousCrawler'))
    return True
  
  return False
