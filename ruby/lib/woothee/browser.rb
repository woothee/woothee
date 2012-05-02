# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Browser
  extend Woothee::Util

  def self.challenge_msie(ua, result)
    return false if ua.index("compatible; MSIE").nil?

    version = if ua =~ /MSIE ([.0-9]+);/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('MSIE'))
    update_version(result, version)
    true
  end

  def self.challenge_safari_chrome(ua, result)
  end

  def self.challenge_firefix(ua, result)
  end

  def self.challenge_opera(ua, result)
  end

  def self.challenge_sleipnir(ua, result)
  end
end
