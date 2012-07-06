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

sub check_is_crawler {
    my ($testsets_file, $set_name, $should_true) = @_;
    my $entries = YAML::LoadFile($testsets_file);
    foreach my $entry (@$entries) {
        if ($should_true and $entry->{category} eq 'crawler') {
            ok ( Woothee::is_crawler($entry->{target}), message($set_name, $entry->{target}, "is_crawler") );
        }
        else {
            ok (! Woothee::is_crawler($entry->{target}), message($set_name, $entry->{target}, "is_crawler") );
        }
    }
}

my $testset_dir = File::Basename::dirname(__FILE__) . "/testsets/";

subtest 'crawler' => sub { check_is_crawler($testset_dir . "crawler.yaml", "Crawler", 1); };
subtest 'crawler_google' => sub { check_is_crawler($testset_dir . "crawler_google.yaml", "Crawler/Google", 1); };
subtest 'pc_windows' => sub { check_is_crawler($testset_dir . "pc_windows.yaml", "PC/Windows", 0); };
subtest 'pc_misc' => sub { check_is_crawler($testset_dir . "pc_misc.yaml", "PC/Misc", 0); };
subtest 'mobilephone_docomo' => sub { check_is_crawler($testset_dir . "mobilephone_docomo.yaml", "MobilePhone/docomo", 0); };
subtest 'mobilephone_au' => sub { check_is_crawler($testset_dir . "mobilephone_au.yaml", "MobilePhone/au", 0); };
subtest 'mobilephone_softbank' => sub { check_is_crawler($testset_dir . "mobilephone_softbank.yaml", "MobilePhone/softbank", 0); };
subtest 'mobilephone_willcom' => sub { check_is_crawler($testset_dir . "mobilephone_willcom.yaml", "MobilePhone/willcom", 0); };
subtest 'mobilephone_misc' => sub { check_is_crawler($testset_dir . "mobilephone_misc.yaml", "MobilePhone/misc", 0); };
subtest 'smartphone_ios' => sub { check_is_crawler($testset_dir . "smartphone_ios.yaml", "SmartPhone/ios", 0); };
subtest 'smartphone_android' => sub { check_is_crawler($testset_dir . "smartphone_android.yaml", "SmartPhone/android", 0); };
subtest 'smartphone_misc' => sub { check_is_crawler($testset_dir . "smartphone_misc.yaml", "SmartPhone/misc", 0); };
subtest 'appliance' => sub { check_is_crawler($testset_dir . "appliance.yaml", "Appliance", 0); };
subtest 'pc_lowpriority' => sub { check_is_crawler($testset_dir . "pc_lowpriority.yaml", "PC/LowPriority", 0); };
subtest 'misc' => sub { check_is_crawler($testset_dir . "misc.yaml", "Misc", 0); };
subtest 'crawler_nonmajor' => sub { check_is_crawler($testset_dir . "crawler_nonmajor.yaml", "Crawler/NonMajor", 0); };

done_testing;
