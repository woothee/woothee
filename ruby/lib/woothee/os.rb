# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::OS
  extend Woothee::Util

  def self.challenge_windows(ua, result)
    return false if ua.index("Windows").nil?

    data = Woothee::DataSet.get('Win')
    unless ua =~ /Windows ([ .a-zA-Z0-9]+)[;\\)]/o
      # Windows, but version unknown
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_NAME])
      return true
    end

    version = $1
    data = case
           when version == 'NT 6.3' then Woothee::DataSet.get('Win8.1')
           when version == 'NT 6.2' then Woothee::DataSet.get('Win8')
           when version == 'NT 6.1' then Woothee::DataSet.get('Win7')
           when version == 'NT 6.0' then Woothee::DataSet.get('WinVista')
           when version == 'NT 5.1' then Woothee::DataSet.get('WinXP')
           when version =~ /^Phone OS/o then Woothee::DataSet.get('WinPhone')
           when version == 'NT 5.0' then Woothee::DataSet.get('Win2000')
           when version == 'NT 4.0' then Woothee::DataSet.get('WinNT4')
           when version == '98' then Woothee::DataSet.get('Win98') # wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
           when version == '95' then Woothee::DataSet.get('Win95')
           when version == 'CE' then Woothee::DataSet.get('WinCE')
           else
             data # windows unknown version
           end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    true
  end

  def self.challenge_osx(ua, result)
    return false if ua.index('Mac OS X').nil?

    data = Woothee::DataSet.get('OSX')
    if ua.index('like Mac OS X')
      data = case
             when ua.index('iPhone;') then Woothee::DataSet.get('iPhone')
             when ua.index('iPad;') then Woothee::DataSet.get('iPad')
             when ua.index('iPod;') then Woothee::DataSet.get('iPod')
             else data
             end
    end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    true
  end

  def self.challenge_linux(ua, result)
    return false if ua.index('Linux').nil?

    data = if ua.index('Android')
             Woothee::DataSet.get('Android')
           else
             Woothee::DataSet.get('Linux')
           end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    true
  end

  def self.challenge_smartphone(ua, result)
    data = case
           when ua.index('iPhone') then Woothee::DataSet.get('iPhone')
           when ua.index('iPad') then Woothee::DataSet.get('iPad')
           when ua.index('iPod') then Woothee::DataSet.get('iPod')
           when ua.index('Android') then Woothee::DataSet.get('Android')
           when ua.index('CFNetwork') then Woothee::DataSet.get('iOS')
           when ua.index('BlackBerry') then Woothee::DataSet.get('BlackBerry')
           else nil
           end

    if result[Woothee::KEY_NAME] && result[Woothee::KEY_NAME] == Woothee::DataSet.get('Firefox')[Woothee::KEY_NAME]
        # Firefox OS specific pattern
        # http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
      if ua =~ /^Mozilla\/[.0-9]+ \(Mobile;(.*;)? rv:[.0-9]+\) Gecko\/[.0-9]+ Firefox\/[.0-9]+$/
        data = Woothee::DataSet.get('FirefoxOS')
      end
    end

    return false unless data

    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    true
  end

  def self.challenge_mobilephone(ua, result)
    if ua.index('KDDI-')
      if ua =~ /KDDI-([^- \/;()"']+)/o
        term = $1
        data = Woothee::DataSet.get('au')
        update_category(result, data[Woothee::KEY_CATEGORY])
        update_os(result, data[Woothee::KEY_OS])
        update_version(result, term)
        return true
      end
    end
    if ua.index('WILLCOM') or ua.index('DDIPOCKET')
      if ua =~ /(?:WILLCOM|DDIPOCKET);[^\/]+\/([^ \/;()]+)/o
        term = $1
        data = Woothee::DataSet.get('willcom')
        update_category(result, data[Woothee::KEY_CATEGORY])
        update_os(result, data[Woothee::KEY_OS])
        update_version(result, term)
        return true
      end
    end
    if ua.index('SymbianOS')
      data = Woothee::DataSet.get('SymbianOS')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end
    if ua.index('Google Wireless Transcoder')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'Google')
      return true
    end
    if ua.index('Naver Transcoder')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'Naver')
      return true
    end

    false
  end

  def self.challenge_appliance(ua, result)
    if ua.index('Nintendo DSi;')
      data = Woothee::DataSet.get('NintendoDSi')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end
    if ua.index('Nintendo Wii;')
      data = Woothee::DataSet.get('NintendoWii')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end

    false
  end

  def self.challenge_misc(ua, result)
    data = case
           when ua.index('(Win98;')
             Woothee::DataSet.get('Win98')
           when ua.index('Macintosh; U; PPC;')
             Woothee::DataSet.get('MacOS')
           when ua.index('Mac_PowerPC')
             Woothee::DataSet.get('MacOS')
           when ua.index('X11; FreeBSD ')
             Woothee::DataSet.get('BSD')
           else
             nil
           end
    if data
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_NAME])
      return true
    end

    false
  end
end
