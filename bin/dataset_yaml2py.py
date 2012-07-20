# -*- coding: utf-8 -*-

import os
import yaml
import datetime

dataset_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
dataset_file = os.path.join(dataset_dir, 'dataset.yaml')
py_file = os.path.join(dataset_dir, 'python', 'lib', 'woothee', 'dataset.py')

generated_timestamp = datetime.datetime.now()
try:
  import pwd
  generated_username = pwd.getpwuid(os.getuid())[0]
except Exception:
  generated_username = os.environ.get('USERNAME')

timestamp = '# GENERATED from dataset.yaml at %s by %s' % (
  generated_timestamp.ctime(), generated_username)

lines = [timestamp]

fp = open(dataset_file, 'rb')
try:
  for datasets in yaml.load_all(fp):
    for dataset in datasets:
      label = dataset['label']
      name = dataset['name']
      type = dataset['type']
      
      # obj = {:label => 'MSIE', :name => 'Internet Explorer', :type => :browser}
      # obj[:vendor] = 'Microsoft'
      # DATASET['MSIE'] = obj
      
      lines.append("obj = {'label': '%s', 'name': '%s', 'type': '%s'}"
        % (label, name, type))
      if type == 'browser':
        lines.append("obj['vendor'] = '%s'" % dataset['vendor'])
      elif type == 'os':
        lines.append("obj['category'] = '%s'" % dataset['category'])
      elif type == 'full':
        if dataset.get('vendor'):
          lines.append("obj['vendor'] = '%s'" % dataset['vendor'])
        lines.append("obj['category'] = '%s'" % dataset['category'])
        if dataset.get('os'):
          lines.append("obj['os'] = '%s'" % dataset['os'])
      else:
        raise Exception('unknown type ' + type)
      lines.append("DATASET[obj['label']] = obj")
finally:
  fp.close()

dynamic_lines = '\n  '.join(lines)

module_text = """\
# -*- coding: utf-8 -*-

KEY_LABEL = 'label'
KEY_NAME = 'name'
KEY_TYPE = 'type'
KEY_CATEGORY = 'category'
KEY_OS = 'os'
KEY_VENDOR = 'vendor'
KEY_VERSION = 'version'

TYPE_BROWSER = 'browser'
TYPE_OS = 'os'
TYPE_FULL = 'full'

CATEGORY_PC = 'pc'
CATEGORY_SMARTPHONE = 'smartphone'
CATEGORY_MOBILEPHONE = 'mobilephone'
CATEGORY_CRAWLER = 'crawler'
CATEGORY_APPLIANCE = 'appliance'
CATEGORY_MISC = 'misc'

ATTRIBUTE_NAME = 'name'
ATTRIBUTE_CATEGORY = 'category'
ATTRIBUTE_OS = 'os'
ATTRIBUTE_VENDOR = 'vendor'
ATTRIBUTE_VERSION = 'version'

VALUE_UNKNOWN = 'UNKNOWN'

CATEGORY_LIST = [CATEGORY_PC,CATEGORY_SMARTPHONE,CATEGORY_MOBILEPHONE,CATEGORY_CRAWLER,CATEGORY_APPLIANCE,CATEGORY_MISC,VALUE_UNKNOWN]
ATTRIBUTE_LIST = [ATTRIBUTE_NAME,ATTRIBUTE_CATEGORY,ATTRIBUTE_OS,ATTRIBUTE_VENDOR,ATTRIBUTE_VERSION]

DATASET = {}

def _init():
  %s

_init()

def get(label):
  return DATASET[label]
""" % dynamic_lines

fp = open(py_file, 'wb')
try:
  fp.write(module_text)
finally:
  fp.close()
