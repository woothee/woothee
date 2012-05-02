# -*- coding: utf-8 -*-

module Woothee::Util
  def update_map(target, source)
    source.keys.each do |key|
      next if key == Woothee::KEY_LABEL or key == Woothee::KEY_TYPE
      if source[key].length > 0
        target[key] = source[key]
      end
    end
  end

  def update_category(target, category)
    target[Woothee::ATTRIBUTE_CATEGORY] = category
  end

  def update_version(target, version)
    target[Woothee::ATTRIBUTE_VERSION] = version
  end

  def update_os(target, os)
    target[Woothee::ATTRIBUTE_OS] = os
  end
end
