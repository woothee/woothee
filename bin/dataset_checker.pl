#!/usr/bin/env perl

use strict;
use warnings;

use feature 'say';

use File::Basename;
use YAML qw//;
# use Data::Dumper;

my @categories = ('pc', 'smartphone', 'mobilephone', 'crawler', 'appliance', 'misc');

my $dataset_file = dirname(__FILE__) . '/../dataset.yaml';
my @testset_files = grep {basename($_) ne 'blank.yaml'} glob(dirname(__FILE__) . '/../testsets/*.yaml');

my $dataset_entries = YAML::LoadFile($dataset_file);
my $dataset = {};
foreach my $entry (@$dataset_entries) {
    if ($dataset->{$entry->{label}}) {
        say 'specified label repeated in dataset, ignored: ', $entry->{label}, "\n";
        next;
    }
    $dataset->{$entry->{label}} = $entry;
    check_dataset_entry($entry);
}
foreach my $testsets_file (@testset_files) {
    my $testset_entries = YAML::LoadFile($testsets_file);
    foreach my $entry (@$testset_entries) {
        check_testset_entry($entry, $testsets_file);
    }
}

sub check_dataset_entry {
    my $entry = shift;
    if (not defined($entry->{name}) or length($entry->{name}) < 1) {
        say 'name attribute not exists for: ', $entry->{label};
    }
    if ($entry->{type} eq 'browser') {
        my @unknowns = grep {!/^(label|name|type|vendor)$/} keys(%$entry);
        if (scalar(@unknowns) > 0) {
            say 'unknown attributes for type "browser" for: ', $entry->{label}, ', attributes: ', join(" ", @unknowns);
        }
    }
    elsif ($entry->{type} eq 'os') {
        if (not defined($entry->{category})) {
            say 'category attribute not exists for: ', $entry->{label};
        }
        else {
            if (scalar(grep {$_ eq $entry->{category}} @categories) < 1) {
                say 'category value is invalid, valid values: ', join('/', @categories), ', for: ', $entry->{label};
            }
        }
        my @unknowns = grep {!/^(label|name|type|category)$/} keys(%$entry);
        if (scalar(@unknowns) > 0) {
            say 'unknown attributes for type "browser" for: ', $entry->{label}, ', attributes: ', join(" ", @unknowns);
        }
    }
    elsif ($entry->{type} eq 'full') {
        if (not defined($entry->{category})) {
            say 'category attribute not exists for: ', $entry->{label};
        }
        else {
            if (scalar(grep {$_ eq $entry->{category}} @categories) < 1) {
                say 'category value is invalid, valid values: ', join('/', @categories), ', for: ', $entry->{label};
            }
        }
        my @unknowns = grep {!/^(label|name|type|vendor|os|category)$/} keys(%$entry);
        if (scalar(@unknowns) > 0) {
            say 'unknown attributes for type "browser" for: ', $entry->{label}, ', attributes: ', join(" ", @unknowns);
        }
    }
    else {
        say 'invalid type "', $entry->{type}, '", valid values: browser/os/full, specified for: ', $entry->{label}
    }
}

sub check_testset_entry {
    my ($entry,$filename) = @_;
    if (not defined($entry->{target}) or length($entry->{target}) < 1) {
        say 'target user-agent string not found at ', $filename;
    }
    foreach my $attr ('name', 'category') {
        if (not defined($entry->{$attr}) or length($entry->{$attr}) < 1) {
            say 'testset needs name and category.';
            say 'target: ', $entry->{target};
        }
    }
}
