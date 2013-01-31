# -*- coding: utf-8 -*-

from . import dataset
from . import util

def challenge_playstation(ua, result):
  if 'PSP (PlayStation Portable);' in ua:
    data = dataset.get('PSP')
  elif 'PlayStation Vita' in ua:
    data = dataset.get('PSVita')
  elif 'PLAYSTATION 3 ' in ua or 'PLAYSTATION 3;' in ua:
    data = dataset.get('PS3')
  else:
    return False
  util.update_map(result, data)
  return True

def challenge_nintendo(ua, result):
  if 'Nintendo 3DS;' in ua:
    data = dataset.get('Nintendo3DS')
  elif 'Nintendo DSi;' in ua:
    data = dataset.get('NintendoDSi')
  elif 'Nintendo Wii;' in ua:
    data = dataset.get('NintendoWii')
  elif '(Nintendo WiiU)' in ua:
    data = dataset.get('NintendoWiiU')
  else:
    return False
  util.update_map(result, data)
  return True

def challenge_digitaltv(ua, result):
  if 'InettvBrowser/' in ua:
    data = dataset.get('DigitalTV')
  else:
    return False
  util.update_map(result, data)
  return True
