# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Crawler
  extend Woothee::Util

  def self.challenge_google(ua, result)
    return false if ua.index('Google').nil?

    if ua.index('compatible; Googlebot')
      if ua.index('compatible; Googlebot-Mobile')
        update_map(result, Woothee::DataSet.get('GoogleBotMobile'))
        return true
      else
        update_map(result, Woothee::DataSet.get('GoogleBot'))
        return true
      end
    end
    if ua.index('Googlebot-Image/')
      update_map(result, Woothee::DataSet.get('GoogleBot'))
      return true
    end
    if ua.index('Mediapartners-Google')
      if ua.index('compatible; Mediapartners-Google') or ua == 'Mediapartners-Google'
        update_map(result, Woothee::DataSet.get('GoogleMediaPartners'))
        return true
      end
    end
    if ua.index('Feedfetcher-Google;')
      update_map(result, Woothee::DataSet.get('GoogleFeedFetcher'))
      return true
    end
    if ua.index('AppEngine-Google')
      update_map(result, Woothee::DataSet.get('GoogleAppEngine'))
      return true
    end
    if ua.index('Google Web Preview')
      update_map(result, Woothee::DataSet.get('GoogleWebPreview'))
      return true
    end

    false
  end

  def self.challenge_crawlers(ua, result)
    if ua.index('Yahoo') or ua.index('help.yahoo.co.jp/help/jp/') or ua.index('listing.yahoo.co.jp/support/faq/')
      if ua.index('compatible; Yahoo! Slurp')
        update_map(result, Woothee::DataSet.get('YahooSlurp'))
        return true
      end
      if ua.index('YahooFeedSeekerJp') or ua.index('YahooFeedSeekerBetaJp')
        update_map(result, Woothee::DataSet.get('YahooJP'))
        return true
      end
      if ua.index('crawler (http://listing.yahoo.co.jp/support/faq/') || ua.index('crawler (http://help.yahoo.co.jp/help/jp/')
        update_map(result, Woothee::DataSet.get('YahooJP'))
        return true
      end
      if ua.index('Yahoo Pipes')
        update_map(result, Woothee::DataSet.get('YahooPipes'))
        return true
      end
    end
    if ua.index('msnbot')
      update_map(result, Woothee::DataSet.get('msnbot'))
      return true
    end
    if ua.index('bingbot')
      if ua.index('compatible; bingbot')
        update_map(result, Woothee::DataSet.get('bingbot'))
        return true
      end
    end
    if ua.index('Baidu')
      if ua.index('compatible; Baiduspider') or ua.index('Baiduspider+') or ua.index('Baiduspider-image+')
        update_map(result, Woothee::DataSet.get('Baiduspider'))
        return true
      end
    end
    if ua.index('Yeti')
      if ua.index('http://help.naver.com/robots')
        update_map(result, Woothee::DataSet.get('Yeti'))
        return true
      end
    end
    if ua.index('FeedBurner/')
      update_map(result, Woothee::DataSet.get('FeedBurner'))
      return true
    end
    if ua.index('facebookexternalhit')
      update_map(result, Woothee::DataSet.get('facebook'))
      return true
    end
    if ua.index('ichiro')
      if ua.index('http://help.goo.ne.jp/door/crawler.html') or ua.index('compatible; ichiro/mobile goo;')
        update_map(result, Woothee::DataSet.get('goo'))
        return true
      end
    end
    if ua.index('gooblogsearch/')
      update_map(result, Woothee::DataSet.get('goo'))
      return true
    end
    if ua.index('Apple-PubSub')
      update_map(result, Woothee::DataSet.get('ApplePubSub'))
      return true
    end
    if ua.index("(www.radian6.com/crawler)")
      update_map(result, Woothee::DataSet.get("radian6"))
      return true
    end
    if ua.index('Genieo/')
      update_map(result, Woothee::DataSet.get("Genieo"))
      return true
    end
    if ua.index("labs.topsy.com/butterfly/")
      update_map(result, Woothee::DataSet.get("topsyButterfly"))
      return true
    end
    if ua.index("rogerbot/1.0 (http://www.seomoz.org/dp/rogerbot")
      update_map(result, Woothee::DataSet.get("rogerbot"))
      return true
    end
    if ua.index("compatible; AhrefsBot/")
      update_map(result, Woothee::DataSet.get("AhrefsBot"))
      return true
    end
    if ua.index('livedoor FeedFetcher') or ua.index('Fastladder FeedFetcher')
      update_map(result, Woothee::DataSet.get('livedoorFeedFetcher'))
      return true
    end
    if ua.index('Hatena ')
      if ua.index('Hatena Antenna') or ua.index('Hatena Pagetitle Agent') or ua.index('Hatena Diary RSS')
        update_map(result, Woothee::DataSet.get('Hatena'))
        return true
      end
    end
    if ua.index('mixi-check') or ua.index('mixi-crawler') or ua.index('mixi-news-crawler')
      update_map(result, Woothee::DataSet.get('mixi'))
      return true
    end
    if ua.index('Indy Library')
      if ua.index('compatible; Indy Library')
        update_map(result, Woothee::DataSet.get('IndyLibrary'))
        return true
      end
    end

    false
  end

  def self.challenge_maybe_crawler(ua, result)
    if ua =~ /(bot|crawler|spider)(?:[-_ .\/;@()]|$)/oi
      update_map(result, Woothee::DataSet.get('VariousCrawler'))
      return true
    end

    if ua =~ /(?:Rome Client |UnwindFetchor\/|ia_archiver |Summify |PostRank\/)/o or ua.index('ASP-Ranker Feed Crawler')
      update_map(result, Woothee::DataSet.get('VariousCrawler'))
      return true
    end

    if ua =~ /(feed|web) ?parser/oi
      update_map(result, Woothee::DataSet.get('VariousCrawler'))
      return true
    end

    if ua =~ /watch ?dog/oi
      update_map(result, Woothee::DataSet.get('VariousCrawler'))
      return true
    end

    false
  end
end
