# -*- coding: utf-8 -*-

import re
from . import dataset
from . import util

def challenge_docomo(ua, result):
  if 'DoCoMo' not in ua and ';FOMA;' not in ua:
    return False
  obj = re.search('DoCoMo/[.0-9]+[ /]([^- /;()"\']+)', ua)
  if obj:
    version = obj.group(1)
  else:
    obj = re.search('\(([^;)]+);FOMA;', ua)
    if obj:
      version = obj.group(1)
    else:
      version = dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('docomo'))
  util.update_version(result, version)
  return True

def challenge_au(ua, result):
  if 'KDDI-' not in ua:
    return False
  obj = re.search('KDDI-([^- /;()"\']+)', ua)
  if obj:
    version = obj.group(1)
  else:
    version = dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('au'))
  util.update_version(result, version)
  return True

def challenge_softbank(ua, result):
  if 'SoftBank' not in ua and 'Vodafone' not in ua and 'J-PHONE' not in ua:
    return False
  obj = re.search('(?:SoftBank|Vodafone|J-PHONE)/[.0-9]+/([^ /;()]+)', ua)
  if obj:
    version = obj.group(1)
  else:
    version = dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('SoftBank'))
  util.update_version(result, version)
  return True

def challenge_willcom(ua, result):
  if 'WILLCOM' not in ua and 'DDIPOCKET' not in ua:
    return False
  obj = re.search('(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)', ua)
  if obj:
    version = obj.group(1)
  else:
    version = dataset.VALUE_UNKNOWN
  util.update_map(result, dataset.get('willcom'))
  util.update_version(result, version)
  return True

def challenge_misc(ua, result):
  if 'jig browser' in ua:
    util.update_map(result, dataset.get('jig'))
    obj = re.search('jig browser[^;]+; ([^);]+)', ua)
    if obj:
      util.update_version(result, obj.group(1))
    return True
  
  if 'emobile/' in ua or 'OpenBrowser' in ua or 'Browser/Obigo-Browser' in ua:
    util.update_map(result, dataset.get('emobile'))
    return True
  
  if 'SymbianOS' in ua:
    util.update_map(result, dataset.get('SymbianOS'))
    return True
  
  if 'Hatena-Mobile-Gateway/' in ua:
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Hatena')
    return True
  
  if 'livedoor-Mobile-Gateway/' in ua:
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'livedoor')
    return True
  
  return False
