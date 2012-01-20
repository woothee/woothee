use strict;
use warnings;
use Test::More;

use File::Basename qw//;
use YAML qw//;

use Woothee;

sub message {
    my ($setname, $target, $attribute) = @_;
    sprintf("%s test(%s): %s", $setname, $attribute, $target);
}

sub run_testset {
    my ($testsets_file, $set_name) = @_;
    my $entries = YAML::LoadFile($testsets_file);
    foreach my $entry (@$entries) {
        my $r = Woothee::parse($entry->{target});
        is ($r->{name}, $entry->{name}, message($set_name, $entry->{target}, "name"));
        is ($r->{category}, $entry->{category}, message($set_name, $entry->{target}, "category"));
        if (exists $entry->{os}) {
            is ($r->{os}, $entry->{os}, message($set_name, $entry->{target}, "os"));
        }
        if (exists $entry->{version}) {
            is ($r->{version}, $entry->{version}, message($set_name, $entry->{target}, "version"));
        }
        if (exists $entry->{vendor}) {
            is ($r->{vendor}, $entry->{vendor}, message($set_name, $entry->{target}, "vendor"));
        }
    }
}

subtest 'crawler' => sub {
    run_testset(File::Basename::dirname(__FILE__) . "/../../testsets/crawler.yaml", "Crawler");
};

done_testing;
