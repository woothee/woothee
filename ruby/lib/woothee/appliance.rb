# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Appliance
  extend Woothee::Util

  def self.challenge_playstation(ua, result)
    data = case
           when ua.index('PSP (PlayStation Portable);') then Woothee::DataSet.get('PSP')
           when ua.index('PlayStation Vita') then Woothee::DataSet.get('PSVita')
           when ua.index('PLAYSTATION 3 ') || ua.index('PLAYSTATION 3;') then Woothee::DataSet.get('PS3')
           else nil
           end
    return false unless data

    update_map(result, data)
    true
  end

  def self.challenge_nintendo(ua, result)
    data = case
           when ua.index('Nintendo 3DS;') then Woothee::DataSet.get('Nintendo3DS')
           when ua.index('Nintendo DSi;') then Woothee::DataSet.get('NintendoDSi')
           when ua.index('Nintendo Wii;') then Woothee::DataSet.get('NintendoWii')
           when ua.index('(Nintendo WiiU)') then Woothee::DataSet.get('NintendoWiiU')
           else nil
           end
    return false unless data

    update_map(result, data)
    true
  end

  def self.challenge_digitaltv(ua, result)
    data = if ua.index('InettvBrowser/')
             Woothee::DataSet.get('DigitalTV')
           else
             nil
           end
    return false unless data

    update_map(result, data)
    true
  end
end
