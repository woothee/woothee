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
end
