#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use YAML qw//;

my $dataset_file = dirname(__FILE__) . '/../dataset.yaml';
my $java_file = dirname(__FILE__) . '/../java/src/java/is/tagomor/woothee/DataSet.java';

open(my $dfh, '-|', 'env', 'LANG=C', 'date');
my $generated_timestamp = <$dfh>;
chomp $generated_timestamp;
close($dfh);
open(my $ufh, '-|', 'env', 'LANG=C', 'whoami');
my $generated_username = <$ufh>;
chomp $generated_username;
close($ufh);
my @defs = (<<"EOI"
  // GENERATED from dataset.yaml at $generated_timestamp by $generated_username
  static {
    Map<String,String> h;
EOI
        );

my $dataset_entries = YAML::LoadFile($dataset_file);
foreach my $dataset (@$dataset_entries) {
    my $label = $dataset->{label};
    my $name = $dataset->{name};
    my $type = $dataset->{type};
    my $def = <<"EOD";
    h = new HashMap<String,String>(6, (float)1.0);
    h.put(DATASET_KEY_LABEL, "$label");
    h.put(DATASET_KEY_NAME, "$name");
    h.put(DATASET_KEY_TYPE, "$type");
EOD
    if ($type eq 'browser') {
        my $vendor = $dataset->{vendor};
        $def .= <<"EOD";
    h.put(DATASET_KEY_VENDOR, "$vendor");
EOD
    }
    elsif ($type eq 'os') {
        my $category = $dataset->{category};
        $def .= <<"EOD";
    h.put(DATASET_KEY_CATEGORY, "$category");
EOD
    }
    elsif ($type eq 'full') {
        my $vendor = $dataset->{vendor} || '';
        my $category = $dataset->{category};
        $def .= <<"EOD";
    h.put(DATASET_KEY_VENDOR, "$vendor");
    h.put(DATASET_KEY_CATEGORY, "$category");
EOD
        if ($dataset->{os}) {
            my $os = $dataset->{os};
            $def .= <<"EOD";
    h.put(DATASET_KEY_OS, "$os");
EOD
        }
    }
    else {
        die "invalid type: " . $dataset->{type};
    }
    $def .= <<"EOD";
    DATASET.put("$label", h);
EOD
    push @defs, $def;
}
push @defs, "  }\n";

open(my $fh, ">", $java_file);
while (my $line = <DATA>) {
    if ($line =~ /^___GENERATED_STATIC_INITIALIZER___/) {
        print $fh join('', @defs);
    }
    else {
        print $fh $line;
    }
}
close($fh);

exit 0;

__DATA__
package is.tagomor.woothee;

import java.util.Map;
import java.util.HashMap;

public final class DataSet {
  public static final String DATASET_KEY_LABEL = "label";
  public static final String DATASET_KEY_NAME = "name";
  public static final String DATASET_KEY_TYPE = "type";
  public static final String DATASET_KEY_CATEGORY = "category";
  public static final String DATASET_KEY_OS = "os";
  public static final String DATASET_KEY_VENDOR = "vendor";
  public static final String DATASET_KEY_VERSION = "version";

  public static final String DATASET_TYPE_BROWSER = "browser";
  public static final String DATASET_TYPE_OS = "os";
  public static final String DATASET_TYPE_FULL = "full";

  public static final String DATASET_CATEGORY_PC = "pc";
  public static final String DATASET_CATEGORY_SMARTPHONE = "smartphone";
  public static final String DATASET_CATEGORY_MOBILEPHONE = "mobilephone";
  public static final String DATASET_CATEGORY_CRAWLER = "crawler";
  public static final String DATASET_CATEGORY_APPLIANCE = "appliance";
  public static final String DATASET_CATEGORY_MISC = "misc";

  public static final String ATTRIBUTE_NAME = "name";
  public static final String ATTRIBUTE_CATEGORY = "category";
  public static final String ATTRIBUTE_OS = "os";
  public static final String ATTRIBUTE_VENDOR = "vendor";
  public static final String ATTRIBUTE_VERSION = "version";
  public static final String VALUE_UNKNOWN = "UNKNOWN";

  public static final String[] CATEGORY_LIST = {
    DATASET_CATEGORY_PC, DATASET_CATEGORY_SMARTPHONE, DATASET_CATEGORY_MOBILEPHONE,
    DATASET_CATEGORY_CRAWLER, DATASET_CATEGORY_APPLIANCE, DATASET_CATEGORY_MISC, VALUE_UNKNOWN
  };
  public static final String[] ATTRIBUTE_LIST = {
    ATTRIBUTE_NAME, ATTRIBUTE_CATEGORY, ATTRIBUTE_OS, ATTRIBUTE_VENDOR, ATTRIBUTE_VERSION
  };

  private static final Map<String,Map<String,String>> DATASET = new HashMap<String,Map<String,String>>();

___GENERATED_STATIC_INITIALIZER___

  public static Map<String,String> get(final String label) {
    return DATASET.get(label);
  }
}
