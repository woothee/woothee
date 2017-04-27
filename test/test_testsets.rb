require 'test/unit'
require 'yaml'
require 'set'

class TestSetsTest < Test::Unit::TestCase
  DATASET_FILE_PATH = File.expand_path('../dataset.yaml', __dir__)
  TESTSET_FILE_PATHS = Dir.glob(File.expand_path('../testsets/*.yaml', __dir__)).reject{|path| File.basename(path) == 'blank.yaml' }

  def setup
    @dataset_entries = YAML.load_file(DATASET_FILE_PATH)
    @dataset = {}
    @dataset_browser_names = Set.new(['UNKNOWN'])
    @dataset_os_names = Set.new(['UNKNOWN'])
    @dataset_vendors = Set.new(['UNKNOWN'])

    @dataset_entries.each do |entry|
      @dataset[entry["label"]] = entry
      case entry["type"]
      when "browser", "full"
        @dataset_browser_names << entry["name"]
        @dataset_os_names << entry["os"] if entry["os"]
      when "os"
        @dataset_os_names << entry["name"]
      end
      @dataset_vendors << entry["vendor"]
    end

    @testsets = {}
    TESTSET_FILE_PATHS.each do |path|
      @testsets[File.basename(path)] = YAML.load_file(path)
    end
  end

  test 'testsets should be arrays of entries' do
    @testsets.each do |filename, entries|
      assert_kind_of Array, entries, "non-array testsets file:#{filename}"
    end
  end

  sub_test_case 'all entries' do
    setup do
      @target_entries = []
      @testsets.each do |filename, entries|
        entries.each do |entry|
          @target_entries << [entry, filename]
        end
      end
    end

    test 'must have target/name/category' do
      @target_entries.each do |entry, filename|
        assert entry["target"] && !entry["target"].empty?, "target is missing:#{entry}, in #{filename}"
        assert entry["name"] && !entry["name"].empty?, "name is missing:#{entry}, in #{filename}"
        assert entry["category"] && !entry["category"].empty?, "category is missing:#{entry}, in #{filename}"
      end
    end

    test 'must have one of known categories' do
      categories = ['pc', 'smartphone', 'mobilephone', 'crawler', 'appliance', 'misc']
      @target_entries.each do |entry, filename|
        assert categories.include?(entry["category"]), "unknown category:#{entry["category"]} of target user-agent:#{entry["target"]}, in #{filename}"
      end
    end

    test 'value of name/os/vendor should be any value defined in dataset' do
      @target_entries.each do |entry, filename|
        assert @dataset_browser_names.include?(entry["name"]), "unknown name:#{entry["name"]} of target user-agent:#{entry["target"]}, in #{filename}"
        if entry["os"]
          assert @dataset_os_names.include?(entry["os"]), "unknown os:#{entry["os"]} of target user-agent:#{entry["target"]}, in #{filename}"
        end
        if entry["vendor"]
          assert @dataset_vendors.include?(entry["vendor"]), "unknown vendor:#{entry["vendor"]} of target user-agent:#{entry["target"]}, in #{filename}"
        end
      end
    end

    test 'should not have unknown attributes (known are target/name/category/version/os/os_version)' do
      known = ['target', 'name', 'category', 'version', 'os', 'os_version']
      @target_entries.each do |entry, filename|
        unknown_attrs = entry.keys.reject{|k| known.include?(k) }
        assert_equal [], unknown_attrs, "unknown attributes #{unknown_attrs}, user-agent:#{entry["target"]}, in #{filename}"
      end
    end
  end
end
