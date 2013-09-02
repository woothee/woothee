# -*- coding: utf-8 -*-

import re
from . import dataset
from . import util

def challenge_msie(ua, result):
  if 'compatible; MSIE' not in ua and 'Trident/' not in ua:
    return False
  version = dataset.VALUE_UNKNOWN
  msie = re.search('MSIE ([.0-9]+);', ua)
  trident = re.search('Trident/([.0-9]+); rv ([.0-9]+)', ua)
  if msie:
    version = msie.group(1)
  elif trident:
    version = trident.group(2)
  util.update_map(result, dataset.get('MSIE'))
  util.update_version(result, version)
  return True

def challenge_safari_chrome(ua, result):
  if 'Safari/' not in ua:
    return False
  version = dataset.VALUE_UNKNOWN
  obj = re.search('(?:Chrome|CrMo|CriOS)/([.0-9]+)', ua)
  if obj:
    # Chrome
    version = obj.group(1)
    util.update_map(result, dataset.get('Chrome'))
    util.update_version(result, version)
    return True
  
  # Safari
  obj = re.search('Version/([.0-9]+)', ua)
  if obj:
    version = obj.group(1)
  util.update_map(result, dataset.get('Safari'))
  util.update_version(result, version)
  return True

def challenge_firefox(ua, result):
  if 'Firefox/' not in ua:
    return False
  obj = re.search('Firefox/([.0-9]+)', ua)
  version = obj.group(1) if obj else dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('Firefox'))
  util.update_version(result, version)
  return True

def challenge_opera(ua, result):
  if 'Opera' not in ua:
    return False
  obj = re.search('Version/([.0-9]+)', ua)
  version = dataset.VALUE_UNKNOWN
  if obj:
    version = obj.group(1)
  else:
    obj = re.search('Opera[/ ]([.0-9]+)', ua)
    if obj:
      version = obj.group(1)
  util.update_map(result, dataset.get('Opera'))
  util.update_version(result, version)
  return True

def challenge_sleipnir(ua, result):
  if 'Sleipnir/' not in ua:
    return False
  obj = re.search('Sleipnir/([.0-9]+)', ua)
  version = obj.group(1) if obj else dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('Sleipnir'))
  util.update_version(result, version)
  # Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
  # Sleipnir is IE component browser, so for Windows only.
  win = dataset.get('Win')
  util.update_category(result, win[dataset.KEY_CATEGORY])
  util.update_os(result, win[dataset.KEY_NAME])
  return True
