# -*- coding: utf-8 -*-

import re
from . import dataset
from . import util

def challenge_windows(ua, result):
  if 'Windows' not in ua:
    return False
  data = dataset.get('Win')
  obj = re.search('Windows ([ .a-zA-Z0-9]+)[;\\)]', ua)
  if not obj:
    # Windows, but version unknown
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_NAME])
    return True
  
  version = obj.group(1)
  if version == 'NT 6.3':
    data = dataset.get('Win8.1')
  elif version == 'NT 6.2':
    data = dataset.get('Win8')
  elif version == 'NT 6.1':
    data = dataset.get('Win7')
  elif version == 'NT 6.0':
    data = dataset.get('WinVista')
  elif version == 'NT 5.1':
    data = dataset.get('WinXP')
  elif re.search('^Phone OS', version):
    data = dataset.get('WinPhone')
  elif version == 'NT 5.0':
    data = dataset.get('Win2000')
  elif version == 'NT 4.0':
    data = dataset.get('WinNT4')
  elif version == '98':
    data = dataset.get('Win98') # wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
  elif version == '95':
    data = dataset.get('Win95')
  elif version == 'CE':
    data = dataset.get('WinCE')
  
  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  return True

def challenge_osx(ua, result):
  if 'Mac OS X' not in ua:
    return False
  data = dataset.get('OSX')
  if 'like Mac OS X' in ua:
    if 'iPhone;' in ua:
      data = dataset.get('iPhone')
    elif 'iPad;' in ua:
      data = dataset.get('iPad')
    elif 'iPod;' in ua:
      data = dataset.get('iPod')
  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  return True

def challenge_linux(ua, result):
  if 'Linux' not in ua:
    return False
  if 'Android' in ua:
    data = dataset.get('Android')
  else:
    data = dataset.get('Linux')
  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  return True

def challenge_smartphone(ua, result):
  data = None
  if 'iPhone' in ua:
    data = dataset.get('iPhone')
  elif 'iPad' in ua:
    data = dataset.get('iPad')
  elif 'iPod' in ua:
    data = dataset.get('iPod')
  elif 'Android' in ua:
    data = dataset.get('Android')
  elif 'CFNetwork' in ua:
    data = dataset.get('iOS')
  elif 'BlackBerry' in ua:
    data = dataset.get('BlackBerry')

  if dataset.KEY_NAME in result and result[dataset.KEY_NAME] == dataset.get('Firefox')[dataset.KEY_NAME]:
    # Firefox OS specific pattern
    # http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
    if re.search('^Mozilla/[.0-9]+ \(Mobile;(.*;)? rv:[.0-9]+\) Gecko/[.0-9]+ Firefox/[.0-9]+$', ua):
      data = dataset.get('FirefoxOS')

  if not data:
    return False

  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  return True

def challenge_mobilephone(ua, result):
  if 'KDDI-' in ua:
    obj = re.search('KDDI-([^- /;()"\']+)', ua)
    if obj:
      term = obj.group(1)
      data = dataset.get('au')
      util.update_category(result, data[dataset.KEY_CATEGORY])
      util.update_os(result, data[dataset.KEY_OS])
      util.update_version(result, term)
      return True
  if 'WILLCOM' in ua or 'DDIPOCKET' in ua:
    obj = re.search('(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)', ua)
    if obj:
      term = obj.group(1)
      data = dataset.get('willcom')
      util.update_category(result, data[dataset.KEY_CATEGORY])
      util.update_os(result, data[dataset.KEY_OS])
      util.update_version(result, term)
      return True
  if 'SymbianOS' in ua:
    data = dataset.get('SymbianOS')
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return True
  if 'Google Wireless Transcoder' in ua:
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Google')
    return True
  if 'Naver Transcoder' in ua:
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Naver')
    return True
  return False

def challenge_appliance(ua, result):
  if 'Nintendo DSi;' in ua:
    data = dataset.get('NintendoDSi')
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return True
  if 'Nintendo Wii;' in ua:
    data = dataset.get('NintendoWii')
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return True
  return False

def challenge_misc(ua, result):
  if '(Win98;' in ua:
    data = dataset.get('Win98')
  elif 'Macintosh; U; PPC;' in ua:
    data = dataset.get('MacOS')
  elif 'Mac_PowerPC' in ua:
    data = dataset.get('MacOS')
  elif 'X11; FreeBSD ' in ua:
    data = dataset.get('BSD')
  else:
    return False
  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  return True
