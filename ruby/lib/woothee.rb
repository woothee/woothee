# -*- coding: utf-8 -*-

require 'woothee/dataset'
#require 'woothee/browser'
#require 'woothee/os'
#require 'woothee/mobilephone'
#require 'woothee/crawler'
#require 'woothee/appliance'
#require 'woothee/misc'

module Woothee
  def self.parse(useragent)
  end

  def self.is_crawler(useragent)
  end

  def self.exec_parse(useragent)
  end

  def self.try_crawler(useragent, result)
  end

  def self.try_browser(useragent, result)
  end

  def self.try_os(useragent, result)
  end

  def self.try_mobilephone(useragent, result)
  end

  def self.try_appliance(useragent, result)
  end

  def self.try_misc(useragent, result)
  end

  def self.try_rare_cases(useragent, result)
  end

  FILLED = {
    Woothee::ATTRIBUTE_NAME => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_CATEGORY => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_OS => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_VERSION => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_VENDOR => Woothee::VALUE_UNKNOWN,
  }.freeze
  def fill_result(result)
    FILLED.merge(result)
  end
end
