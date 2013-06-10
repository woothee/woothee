# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Misc
  extend Woothee::Util

  def self.challenge_desktoptools(ua, result)
    data = case
           when ua.index('AppleSyndication/') then Woothee::DataSet.get('SafariRSSReader')
           when ua.index('compatible; Google Desktop/') then Woothee::DataSet.get('GoogleDesktop')
           when ua.index('Windows-RSS-Platform') then Woothee::DataSet.get('WindowsRSSReader')
           else nil
           end
    return false unless data

    update_map(result, data)
    true
  end

  def self.challenge_smartphone_patterns(ua, result)
    if ua.index('CFNetwork/')
      data = Woothee::DataSet.get('iOS')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_NAME])
      return true
    end

    false
  end

  def self.challenge_http_library(ua, result)
    data,version = case
                   when ua =~ /^(?:Apache-HttpClient\/|Jakarta Commons-HttpClient\/|Java\/)/o || ua =~ /[- ]HttpClient(\/|$)/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'Java']
                   when ua.index('Java(TM) 2 Runtime Environment,')
                     [Woothee::DataSet.get('HTTPLibrary'), 'Java']
                   when ua =~ /^Wget/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'wget']
                   when ua =~ /^(?:libwww-perl|WWW-Mechanize|LWP::Simple|LWP |lwp-trivial)/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'perl']
                   when ua =~ /^(?:Ruby|feedzirra|Typhoeus)/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'ruby']
                   when ua =~ /^(Python-urllib\/|Twisted )/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'python']
                   when ua =~ /^(?:PHP|WordPress|CakePHP|PukiWiki|PECL::HTTP)(?:\/| |$)/o || ua =~ /(?:PEAR |)HTTP_Request(?: class|2)/o
                     [Woothee::DataSet.get('HTTPLibrary'), 'php']
                   else [nil,nil]
                   end
    return false unless data

    update_map(result, data)
    update_version(result, version)
    true
  end

  def self.challenge_maybe_rss_reader(ua, result)
    data = if ua =~ /rss(?:reader|bar|[-_ \/;()]|[ +]*\/)/oi || ua =~ /headline-reader/oi
             Woothee::DataSet.get('VariousRSSReader')
           elsif ua.index('cococ/')
             Woothee::DataSet.get('VariousRSSReader')
           else
             nil
           end
    return false unless data

    update_map(result, data)
    true
  end
end
