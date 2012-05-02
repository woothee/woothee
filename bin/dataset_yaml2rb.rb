#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'yaml'

dataset_file = File.dirname(__FILE__) + '/../dataset.yaml';
rb_file = File.dirname(__FILE__) + '/../ruby/lib/woothee/dataset.rb';

generated_timestamp = open("|env LANG=C date") {|io|
  io.readline().chomp
}
generated_username = open("|env LANG=C whoami") {|io|
  io.readline().chomp
}
timestamp = "# GENERATED from dataset.yaml at #{generated_timestamp} by #{generated_username}"

lines = [timestamp]

YAML.load_file(dataset_file).each do |dataset|
  label = dataset['label']
  name = dataset['name']
  type = dataset['type']
  
  # obj = {:label => 'MSIE', :name => 'Internet Explorer', :type => :browser}
  # obj[:vendor] = 'Microsoft'
  # DATASET['MSIE'] = obj

  lines.push "obj = {:label => '#{label}', :name => '#{name}', :type => :#{type}}"
  case type
  when 'browser'
    lines.push "obj[:vendor] = '#{dataset['vendor']}'"
  when 'os'
    lines.push "obj[:category] = :#{dataset['category']}"
  when 'full'
    lines.push "obj[:vendor] = '#{dataset['vendor']}'" if dataset['vendor']
    lines.push "obj[:category] = :#{dataset['category']}"
    if dataset['os']
      lines.push "obj[:os] = '#{dataset['os']}'"
    end
  else
    raise StandardError, "unknown type #{type}"
  end
  lines.push "DATASET[obj[:label]] = obj"
end

dynamic_lines = lines.join("\n  ") + "\n"

module_text = <<EOT
# -*- coding: utf-8 -*-
module Woothee
  KEY_LABEL = :label
  KEY_NAME = :name
  KEY_TYPE = :type
  KEY_CATEGORY = :category
  KEY_OS = :os
  KEY_VENDOR = :vendor
  KEY_VERSION = :version

  TYPE_BROWSER = :browser
  TYPE_OS = :os
  TYPE_FULL = :full

  CATEGORY_PC = :pc
  CATEGORY_SMARTPHONE = :smartphone
  CATEGORY_MOBILEPHONE = :mobilephone
  CATEGORY_CRAWLER = :crawler
  CATEGORY_APPLIANCE = :appliance
  CATEGORY_MISC = :misc

  ATTRIBUTE_NAME = :name
  ATTRIBUTE_CATEGORY = :category
  ATTRIBUTE_OS = :os
  ATTRIBUTE_VENDOR = :vendor
  ATTRIBUTE_VERSION = :version

  VALUE_UNKNOWN = "UNKNOWN"
end

module Woothee::DataSet
  DATASET = {}
  #{dynamic_lines}
  DATASET.freeze

  def self.get(label)
    DATASET[label]
  end
end
EOT

open(rb_file, 'w') {|io|
  io.write module_text
}
