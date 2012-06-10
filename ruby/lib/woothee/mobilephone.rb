# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::MobilePhone
  extend Woothee::Util

  def self.challenge_docomo(ua, result)
    return false if ua.index('DoCoMo').nil? and ua.index(';FOMA;').nil?

    version = if ua =~ /DoCoMo\/[.0-9]+[ \/]([^- \/;()"']+)/o
                $1
              elsif ua =~ /\(([^;)]+);FOMA;/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('docomo'))
    update_version(result, version)
    true
  end

  def self.challenge_au(ua, result)
    return false if ua.index('KDDI-').nil?

    # fix Woothee::OS.challenge_mobile if you want to fix here
    version = if ua =~ /KDDI-([^- \/;()"']+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('au'))
    update_version(result, version)
    true
  end

  def self.challenge_softbank(ua, result)
    return false if ua.index('SoftBank').nil? and ua.index('Vodafone').nil? and ua.index('J-PHONE').nil?

    version = if ua =~ /(?:SoftBank|Vodafone|J-PHONE)\/[.0-9]+\/([^ \/;()]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('SoftBank'))
    update_version(result, version)
    true
  end

  def self.challenge_willcom(ua, result)
    return false if ua.index('WILLCOM').nil? and ua.index('DDIPOCKET').nil?

    # fix Woothee::OS.challenge_mobile if you want to fix here
    version = if ua =~ /(?:WILLCOM|DDIPOCKET);[^\/]+\/([^ \/;()]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('willcom'))
    update_version(result, version)
    true
  end

  def self.challenge_misc(ua, result)
    if ua.index('jig browser')
      update_map(result, Woothee::DataSet.get('jig'))
      if ua =~ /jig browser[^;]+; ([^);]+)/o
        update_version(result, $1)
      end
      return true
    end
    if ua.index('emobile/') or ua.index('OpenBrowser') or ua.index('Browser/Obigo-Browser')
      update_map(result, Woothee::DataSet.get('emobile'))
      return true
    end
    if ua.index('SymbianOS')
      update_map(result, Woothee::DataSet.get('SymbianOS'))
      return true
    end
    if ua.index('Hatena-Mobile-Gateway/')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'Hatena')
      return true
    end
    if ua.index('livedoor-Mobile-Gateway/')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'livedoor')
      return true
    end

    false
  end
end
