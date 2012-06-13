# -*- coding: utf-8 -*-

from . import dataset
from . import browser
from . import os
from . import mobilephone
from . import crawler
from . import appliance
from . import misc

FILLED = {
  dataset.ATTRIBUTE_NAME: dataset.VALUE_UNKNOWN,
  dataset.ATTRIBUTE_CATEGORY: dataset.VALUE_UNKNOWN,
  dataset.ATTRIBUTE_OS: dataset.VALUE_UNKNOWN,
  dataset.ATTRIBUTE_VERSION: dataset.VALUE_UNKNOWN,
  dataset.ATTRIBUTE_VENDOR: dataset.VALUE_UNKNOWN,
}

def parse(useragent):
  return fill_result(exec_parse(useragent))

def is_crawler(useragent):
  return len(useragent) > 0 and useragent != '-' and try_crawler(useragent, {})

def exec_parse(useragent):
  result = {}
  
  if len(useragent) < 1 or useragent == '-':
    return result
  
  if try_crawler(useragent, result):
    return result
  
  if try_browser(useragent, result):
    try_os(useragent, result)
    return result
  
  if try_mobilephone(useragent, result):
    return result
  
  if try_appliance(useragent, result):
    return result
  
  if try_misc(useragent, result):
    return result
  
  # browser unknown. check os only
  if try_os(useragent, result):
    return result
  
  try_rare_cases(useragent, result)
  
  return result

def try_crawler(useragent, result):
  if crawler.challenge_google(useragent, result):
    return True
  if crawler.challenge_crawlers(useragent, result):
    return True
  return False

def try_browser(useragent, result):
  if browser.challenge_msie(useragent, result):
    return True
  if browser.challenge_safari_chrome(useragent, result):
    return True
  if browser.challenge_firefox(useragent, result):
    return True
  if browser.challenge_opera(useragent, result):
    return True
  return False

def try_os(useragent, result):
  if os.challenge_windows(useragent, result):
    return True
  # OSX PC and iOS devices (strict check)
  if os.challenge_osx(useragent, result):
    return True
  # Linux PC and Android
  if os.challenge_linux(useragent, result):
    return True
  # all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
  if os.challenge_smartphone(useragent, result):
    return True
  # mobile phones like KDDI-.*
  if os.challenge_mobilephone(useragent, result):
    return True
  # Nintendo DSi/Wii with Opera
  if os.challenge_appliance(useragent, result):
    return True
  # Win98, BSD, classic MacOS, ...
  if os.challenge_misc(useragent, result):
    return True
  return False

def try_mobilephone(useragent, result):
  if mobilephone.challenge_docomo(useragent, result):
    return True
  if mobilephone.challenge_au(useragent, result):
    return True
  if mobilephone.challenge_softbank(useragent, result):
    return True
  if mobilephone.challenge_willcom(useragent, result):
    return True
  if mobilephone.challenge_misc(useragent, result):
    return True
  return False

def try_appliance(useragent, result):
  if appliance.challenge_playstation(useragent, result):
    return True
  if appliance.challenge_nintendo(useragent, result):
    return True
  if appliance.challenge_digitaltv(useragent, result):
    return True
  return False

def try_misc(useragent, result):
  if misc.challenge_desktoptools(useragent, result):
    return True
  return False

def try_rare_cases(useragent, result):
  if misc.challenge_smartphone_patterns(useragent, result):
    return True
  if browser.challenge_sleipnir(useragent, result):
    return True
  if misc.challenge_http_library(useragent, result):
    return True
  if misc.challenge_maybe_rss_reader(useragent, result):
    return True
  if crawler.challenge_maybe_crawler(useragent, result):
    return True
  return False

def fill_result(result):
  merged = FILLED.copy()
  merged.update(result)
  return merged
