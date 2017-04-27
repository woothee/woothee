require 'test/unit'
require 'yaml'

class DataSetTest < Test::Unit::TestCase
  DATASET_FILE_PATH = File.expand_path('../dataset.yaml', __dir__)

  def setup
    @dataset_entries = YAML.load_file(DATASET_FILE_PATH)
  end

  test 'dataset file lists entries' do
    assert_kind_of Array, @dataset_entries
  end

  sub_test_case 'all entries' do
    test 'must have label and type attributes' do
      @dataset_entries.each do |entry|
        assert entry["label"] && !entry["label"].empty?, "label is missing:#{entry}"
        assert entry["type"] && !entry["type"].empty?, "type is missing:#{entry}"
      end
    end

    test 'must be one type of browser/os/full' do
      types = ["browser", "os", "full"]
      @dataset_entries.each do |entry|
        assert types.include?(entry["type"]), "unknown type:#{entry["type"]} of label:#{entry["label"]}"
      end
    end
  end

  sub_test_case 'browser entries' do
    setup do
      @target_entries = @dataset_entries.select{|e| e["type"] == "browser" }
    end

    test 'should have name and vendor' do
      @target_entries.each do |entry|
        assert entry["name"] && !entry["name"].empty?, "name is missing:#{entry["label"]}"
        assert entry["vendor"] && !entry["vendor"].empty?, "vendor is missing:#{entry["label"]}"
      end
    end

    test 'shoud not have unknown attributes (known are label/name/type/vendor)' do
      known = ["label", "type", "name", "vendor"]
      @target_entries.each do |entry|
        unknown_attrs = entry.keys.reject{|k| known.include?(k) }
        assert_equal [], unknown_attrs, "unknown attributes #{unknown_attrs} for label #{entry['label']}"
      end
    end
  end

  sub_test_case 'os entries' do
    setup do
      @target_entries = @dataset_entries.select{|e| e["type"] == "os" }
    end

    test 'should have name and category' do
      @target_entries.each do |entry|
        assert entry["name"] && !entry["name"].empty?, "name is missing:#{entry["label"]}"
        assert entry["category"] && !entry["category"].empty?, "category is missing:#{entry["label"]}"
      end
    end

    test 'must be one category of pc/smartphone/mobilephone/crawler/appliance/misc' do
      categories = ['pc', 'smartphone', 'mobilephone', 'crawler', 'appliance', 'misc']
      @target_entries.each do |entry|
        assert categories.include?(entry["category"]), "unknown category:#{entry["category"]} of label:#{entry["label"]}"
      end
    end

    test 'shoud not have unknown attributes (known are label/name/type/category)' do
      known = ["label", "type", "name", "category"]
      @target_entries.each do |entry|
        unknown_attrs = entry.keys.reject{|k| known.include?(k) }
        assert_equal [], unknown_attrs, "unknown attributes #{unknown_attrs} for label #{entry['label']}"
      end
    end
  end

  sub_test_case 'full entries' do
    setup do
      @target_entries = @dataset_entries.select{|e| e["type"] == "full" }
    end

    test 'should have name and category (vendor/os are optional)' do
      @target_entries.each do |entry|
        assert entry["name"] && !entry["name"].empty?, "name is missing:#{entry["label"]}"
        assert entry["category"] && !entry["category"].empty?, "category is missing:#{entry["label"]}"
      end
    end

    test 'must be one category of pc/smartphone/mobilephone/crawler/appliance/misc' do
      categories = ['pc', 'smartphone', 'mobilephone', 'crawler', 'appliance', 'misc']
      @target_entries.each do |entry|
        assert categories.include?(entry["category"]), "unknown category:#{entry["category"]} of label:#{entry["label"]}"
      end
    end

    test 'shoud not have unknown attributes (known are label/name/type/vendor/os/category)' do
      known = ["label", "type", "name", "vendor", "os", "category"]
      @target_entries.each do |entry|
        unknown_attrs = entry.keys.reject{|k| known.include?(k) }
        assert_equal [], unknown_attrs, "unknown attributes #{unknown_attrs} for label #{entry['label']}"
      end
    end
  end
end
