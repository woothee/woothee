#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use YAML qw//;

my $dataset_file = dirname(__FILE__) . '/../dataset.yaml';
my $java_file = dirname(__FILE__) . '/../js/lib/dataset.js';

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
var obj;
EOI
        );

my $dataset_entries = YAML::LoadFile($dataset_file);
foreach my $dataset (@$dataset_entries) {
    my $label = $dataset->{label};
    my $name = $dataset->{name};
    my $type = $dataset->{type};
    my $def = <<"EOD";
obj = {label:'$label', name:'$name', type:'$type'};
EOD
    if ($type eq 'browser') {
        my $vendor = $dataset->{vendor};
        $def .= <<"EOD";
obj['vendor'] = '$vendor';
EOD
    }
    elsif ($type eq 'os') {
        my $category = $dataset->{category};
        $def .= <<"EOD";
obj['category'] = '$category';
EOD
    }
    elsif ($type eq 'full') {
        my $vendor = $dataset->{vendor} || '';
        my $category = $dataset->{category};
        $def .= <<"EOD";
obj['vendor'] = '$vendor';
obj['category'] = '$category';
EOD
        if ($dataset->{os}) {
            my $os = $dataset->{os};
            $def .= <<"EOD";
obj['os'] = '$os';
EOD
        }
    }
    else {
        die "invalid type: " . $dataset->{type};
    }
    $def .= <<"EOD";
DATASET[obj.label] = obj;
EOD
    push @defs, $def;
}
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
var KEY_LABEL = exports.KEY_LABEL = 'label',
    KEY_NAME = exports.KEY_NAME = 'name',
    KEY_TYPE = exports.KEY_TYPE = 'type',
    KEY_CATEGORY = exports.KEY_CATEGORY = 'category',
    KEY_OS = exports.KEY_OS = 'os',
    KEY_VENDOR = exports.KEY_VENDOR = 'vendor',
    KEY_VERSION = exports.KEY_VERSION = 'version';

var TYPE_BROWSER = 'browser',
    TYPE_OS = 'os',
    TYPE_FULL = 'full';

var CATEGORY_PC = exports.CATEGORY_PC = 'pc',
    CATEGORY_SMARTPHONE = exports.CATEGORY_SMARTPHONE = 'smartphone',
    CATEGORY_MOBILEPHONE = exports.CATEGORY_MOBILEPHONE = 'mobilephone',
    CATEGORY_CRAWLER = exports.CATEGORY_CRAWLER = 'crawler',
    CATEGORY_APPLIANCE = exports.CATEGORY_APPLIANCE = 'appliance',
    CATEGORY_MISC = exports.CATEGORY_MISC = 'misc';

var ATTRIBUTE_NAME = exports.ATTRIBUTE_NAME = 'name',
    ATTRIBUTE_CATEGORY = exports.ATTRIBUTE_CATEGORY = 'category',
    ATTRIBUTE_OS = exports.ATTRIBUTE_OS = 'os',
    ATTRIBUTE_VENDOR = exports.ATTRIBUTE_VENDOR = 'vendor',
    ATTRIBUTE_VERSION = exports.ATTRIBUTE_VERSION = 'version';

var VALUE_UNKNOWN = exports.VALUE_UNKNOWN = 'UNKNOWN';

var CATEGORY_LIST = exports.CATEGORY_LIST = [
  CATEGORY_PC, CATEGORY_SMARTPHONE, CATEGORY_MOBILEPHONE,
  CATEGORY_CRAWLER, CATEGORY_APPLIANCE, CATEGORY_MISC, VALUE_UNKNOWN
];
var ATTRIBUTE_LIST = exports.ATTRIBUTE_LIST = [ATTRIBUTE_NAME, ATTRIBUTE_CATEGORY, ATTRIBUTE_OS, ATTRIBUTE_VENDOR, ATTRIBUTE_VERSION];

var DATASET = {};

___GENERATED_STATIC_INITIALIZER___

var get = exports.get = function(label) {
  return DATASET[label];
};
