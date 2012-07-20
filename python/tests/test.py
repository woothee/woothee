# -*- coding:utf-8 -*-

import os
import sys
import unittest

_FILE_PATH = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(_FILE_PATH, 'lib'))

import yaml

TESTSET_DIR = os.path.join(os.path.dirname(_FILE_PATH), 'testsets')

TARGETS = [
           ['crawler.yaml','Crawler'],['crawler_google.yaml','Crawler/Google'],
           ['pc_windows.yaml','PC/Windows'],['pc_misc.yaml','PC/Misc'],
           ['mobilephone_docomo.yaml','MobilePhone/docomo'],['mobilephone_au.yaml','MobilePhone/au'],
           ['mobilephone_softbank.yaml','MobilePhone/softbank'],['mobilephone_willcom.yaml','MobilePhone/willcom'],
           ['mobilephone_misc.yaml','MobilePhone/misc'],
           ['smartphone_ios.yaml','SmartPhone/ios'],['smartphone_android.yaml','SmartPhone/android'],
           ['smartphone_misc.yaml','SmartPhone/misc'],
           ['appliance.yaml','Appliance'],
           ['pc_lowpriority.yaml','PC/LowPriority'],
           ['misc.yaml','Misc'],
           ['crawler_nonmajor.yaml','Crawler/NonMajor'],
          ]

class WootheeTest(unittest.TestCase):
  def test_contains_constants(self):
    from woothee import dataset
    self.assertEqual(dataset.ATTRIBUTE_NAME, 'name')
  
  def test_contains_const_list(self):
    from woothee import dataset
    self.assertEqual(dataset.ATTRIBUTE_LIST,
                     [dataset.ATTRIBUTE_NAME, dataset.ATTRIBUTE_CATEGORY, dataset.ATTRIBUTE_OS,
                      dataset.ATTRIBUTE_VENDOR, dataset.ATTRIBUTE_VERSION])
    self.assertEqual(dataset.CATEGORY_LIST,
                     [dataset.CATEGORY_PC, dataset.CATEGORY_SMARTPHONE, dataset.CATEGORY_MOBILEPHONE,
                      dataset.CATEGORY_CRAWLER, dataset.CATEGORY_APPLIANCE, dataset.CATEGORY_MISC,
                      dataset.VALUE_UNKNOWN])

  def test_contains_dataset(self):
    from woothee import dataset
    self.assertEqual(dataset.get('GoogleBot')['name'], 'Googlebot')
  
  def test_should_be_read_from_each_modules_correctly(self):
    import woothee
    from woothee import dataset
  
  def test_testsets(self):
    import woothee
    for filename, groupname in TARGETS:
      f = open(os.path.join(TESTSET_DIR, filename), 'rb')
      try:
        for es in yaml.load_all(f):
          for e in es:
            r = woothee.parse(e['target'])
            for attribute in ('name', 'category', 'os', 'version', 'vendor'):
              testname = groupname + (' test(%s): %s' % (attribute, e['target']))
              if attribute in ('name', 'category') or \
                (attribute in ('os', 'version', 'vendor') and \
                  attribute in e):
                #print r[attribute], e[attribute]
                self.assertEqual(r[attribute], e[attribute], testname)
      finally:
        f.close()

if __name__ == '__main__':
  unittest.main()
