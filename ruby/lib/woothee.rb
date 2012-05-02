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
    fill_result(exec_parse(useragent))
 end

  def self.is_crawler(useragent)
    useragent.length > 0 and useragent != '-' and try_crawler(useragent, {})
  end

  def self.exec_parse(useragent)
    result = {}

    return result if useragent.lenght < 1 or useragent == '-'

    if try_crawler(useragent, result)
      return result
    end

    if try_browser(useragent, result)
      if try_os(useragent, result)
        return result
      else
        return result
      end
    end

    if try_mobilephone(useragent, result)
      return result
    end

    if try_appliance(useragent, result)
      return result
    end

    if try_misc(useragent, result)
      return result
    end

    # browser unknown. check os only
    if try_os(useragent, result)
      return result
    end

    if try_rare_cases(useragent, result)
      return result
    end

    result
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
