#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
use YAML qw//;

my $dataset_file = dirname(__FILE__) . '/../dataset.yaml';
my $java_file = dirname(__FILE__) . '/../perl/lib/Woothee/DataSet.pm';

open(my $dfh, '-|', 'env', 'LANG=C', 'date');
my $generated_timestamp = <$dfh>;
chomp $generated_timestamp;
close($dfh);
open(my $ufh, '-|', 'env', 'LANG=C', 'whoami');
my $generated_username = <$ufh>;
chomp $generated_username;
close($ufh);
my @defs = (<<"EOI"
    # GENERATED from dataset.yaml at $generated_timestamp by $generated_username
    my \$obj;
EOI
        );

my $dataset_entries = YAML::LoadFile($dataset_file);
foreach my $dataset (@$dataset_entries) {
    my $label = $dataset->{label};
    my $name = $dataset->{name};
    my $type = $dataset->{type};
    my $def = <<"EOD";
    \$obj = {label => '$label', name => '$name', type => '$type'};
EOD
    if ($type eq 'browser') {
        my $vendor = $dataset->{vendor};
        $def .= <<"EOD";
    \$obj->{vendor} = '$vendor';
EOD
    }
    elsif ($type eq 'os') {
        my $category = $dataset->{category};
        $def .= <<"EOD";
    \$obj->{category} = '$category';
EOD
    }
    elsif ($type eq 'full') {
        my $vendor = $dataset->{vendor} || '';
        my $category = $dataset->{category};
        $def .= <<"EOD";
    \$obj->{category} = '$category';
    \$obj->{vendor} = '$vendor';
EOD
        if ($dataset->{os}) {
            my $os = $dataset->{os};
            $def .= <<"EOD";
    \$obj->{os} = '$os';
EOD
        }
    }
    else {
        die "invalid type: " . $dataset->{type};
    }
    $def .= <<"EOD";
    \$DATASET->{'$label'} = \$obj;
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
package Woothee::DataSet;

use strict;
use warnings;
use Carp;

my $DATASET_KEY_LABEL = "label";
my $DATASET_KEY_NAME = "name";
my $DATASET_KEY_TYPE = "type";
my $DATASET_KEY_CATEGORY = "category";
my $DATASET_KEY_OS = "os";
my $DATASET_KEY_VENDOR = "vendor";
my $DATASET_KEY_VERSION = "version";

my $DATASET_TYPE_BROWSER = "browser";
my $DATASET_TYPE_OS = "os";
my $DATASET_TYPE_FULL = "full";

my $DATASET_CATEGORY_PC = "pc";
my $DATASET_CATEGORY_SMARTPHONE = "smartphone";
my $DATASET_CATEGORY_MOBILEPHONE = "mobilephone";
my $DATASET_CATEGORY_CRAWLER = "crawler";
my $DATASET_CATEGORY_APPLIANCE = "appliance";
my $DATASET_CATEGORY_MISC = "misc";

my $ATTRIBUTE_NAME = "name";
my $ATTRIBUTE_CATEGORY = "category";
my $ATTRIBUTE_OS = "os";
my $ATTRIBUTE_VENDOR = "vendor";
my $ATTRIBUTE_VERSION = "version";
my $VALUE_UNKNOWN = "UNKNOWN";

my $DATASET = {};
# $DATASET->{label} = {name => ....};

___GENERATED_STATIC_INITIALIZER___

sub get {
    my ($klass, $label) = @_;
    $label = $klass unless $label;
    $DATASET->{$label};
}

1;
