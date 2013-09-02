# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Browser
  extend Woothee::Util

  def self.challenge_msie(ua, result)
    return false if ua.index("compatible; MSIE").nil? && ua.index("Trident/").nil?

    version = if ua =~ /MSIE ([.0-9]+);/o
                $1
              elsif ua =~ /Trident\/([.0-9]+); rv ([.0-9]+)/o
                $2
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('MSIE'))
    update_version(result, version)
    true
  end

  def self.challenge_safari_chrome(ua, result)
    return false if ua.index('Safari/').nil?

    version = Woothee::VALUE_UNKNOWN

    if ua =~ /(?:Chrome|CrMo|CriOS)\/([.0-9]+)/o
      # Chrome
      version = $1
      update_map(result, Woothee::DataSet.get('Chrome'))
      update_version(result, version)
      return true
    end

    # Safari
    if ua =~ /Version\/([.0-9]+)/o
      version = $1
    end
    update_map(result, Woothee::DataSet.get('Safari'))
    update_version(result, version)
    true
  end

  def self.challenge_firefox(ua, result)
    return false if ua.index('Firefox/').nil?

    version = if ua =~ /Firefox\/([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Firefox'))
    update_version(result, version)
    true
  end

  def self.challenge_opera(ua, result)
    return false if ua.index('Opera').nil?

    version = if ua =~ /Version\/([.0-9]+)/o
                $1
              elsif ua =~ /Opera[\/ ]([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Opera'))
    update_version(result, version)
    true
  end

  def self.challenge_sleipnir(ua, result)
    return false if ua.index('Sleipnir/').nil?

    version = if ua =~ /Sleipnir\/([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Sleipnir'))
    update_version(result, version)

    # Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
    # Sleipnir is IE component browser, so for Windows only.
    win = Woothee::DataSet.get('Win')
    update_category(result, win[Woothee::KEY_CATEGORY])
    update_os(result, win[Woothee::KEY_NAME])

    true
  end
end
