package Woothee::Util;

use strict;
use warnings;
use Carp;

use Woothee::DataSet;

our $VERSION = "0.2.1";

our (@ISA, @EXPORT_OK);
BEGIN {
    require Exporter;
    our @ISA = qw(Exporter);
    our @EXPORT_OK = qw(update_map update_category update_version update_os);
}

sub update_map {
    my ($target,$source) = @_;
    foreach my $key (%$source) {
        next if $key eq Woothee::DataSet->const('KEY_LABEL') or $key eq Woothee::DataSet->const('KEY_TYPE');
        if (defined($source->{$key}) and length($source->{$key}) > 0) {
            $target->{$key} = $source->{$key};
        }
    }
}

sub update_category {
    my ($target,$category) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_CATEGORY')} = $category;
}

sub update_version {
    my ($target,$version) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_VERSION')} = $version;
}

sub update_os {
    my ($target,$os) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_OS')} = $os;
}

1;
