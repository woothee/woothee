# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/browser'
require 'woothee/os'
require 'woothee/mobilephone'
require 'woothee/crawler'
require 'woothee/appliance'
require 'woothee/misc'

module Woothee
  def self.parse(useragent)
    fill_result(exec_parse(useragent))
 end

  def self.is_crawler(useragent)
    useragent.length > 0 and useragent != '-' and try_crawler(useragent, {})
  end

  def self.exec_parse(useragent)
    result = {}

    return result if useragent.length < 1 or useragent == '-'

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
    return true if Woothee::Crawler.challenge_google(useragent, result)

    return true if Woothee::Crawler.challenge_crawlers(useragent, result)

    false
  end

  def self.try_browser(useragent, result)
    return true if Woothee::Browser.challenge_msie(useragent, result)

    return true if Woothee::Browser.challenge_safari_chrome(useragent, result)

    return true if Woothee::Browser.challenge_firefox(useragent, result)

    return true if Woothee::Browser.challenge_opera(useragent, result)

    false
  end

  def self.try_os(useragent, result)
    return true if Woothee::OS.challenge_windows(useragent, result)

    # OSX PC and iOS devices (strict check)
    return true if Woothee::OS.challenge_osx(useragent, result)

    # Linux PC and Android
    return true if Woothee::OS.challenge_linux(useragent, result)

    # all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
    return true if Woothee::OS.challenge_smartphone(useragent, result)

    # mobile phones like KDDI-.*
    return true if Woothee::OS.challenge_mobilephone(useragent, result)

    # Nintendo DSi/Wii with Opera
    return true if Woothee::OS.challenge_appliance(useragent, result)

    # Win98, BSD, classic MacOS, ...
    return true if Woothee::OS.challenge_misc(useragent, result)

    false
  end

  def self.try_mobilephone(useragent, result)
    return true if Woothee::MobilePhone.challenge_docomo(useragent, result)

    return true if Woothee::MobilePhone.challenge_au(useragent, result)

    return true if Woothee::MobilePhone.challenge_softbank(useragent, result)

    return true if Woothee::MobilePhone.challenge_willcom(useragent, result)

    return true if Woothee::MobilePhone.challenge_misc(useragent, result)

    false
  end

  def self.try_appliance(useragent, result)
    return true if Woothee::Appliance.challenge_playstation(useragent, result)

    return true if Woothee::Appliance.challenge_nintendo(useragent, result)

    return true if Woothee::Appliance.challenge_digitaltv(useragent, result)

    false
  end

  def self.try_misc(useragent, result)
    return true if Woothee::Misc.challenge_desktoptools(useragent, result)

    false
  end

  def self.try_rare_cases(useragent, result)
    return true if Woothee::Misc.challenge_smartphone_patterns(useragent, result)

    return true if Woothee::Browser.challenge_sleipnir(useragent, result)

    return true if Woothee::Misc.challenge_http_library(useragent, result)

    return true if Woothee::Misc.challenge_maybe_rss_reader(useragent, result)

    return true if Woothee::Crawler.challenge_maybe_crawler(useragent, result)

    false
  end

  FILLED = {
    Woothee::ATTRIBUTE_NAME => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_CATEGORY => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_OS => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_VERSION => Woothee::VALUE_UNKNOWN,
    Woothee::ATTRIBUTE_VENDOR => Woothee::VALUE_UNKNOWN,
  }.freeze
  def self.fill_result(result)
    FILLED.merge(result)
  end
end
