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
        my $r1 = Woothee::parse($entry->{target});
        my $r2 = Woothee->parse($entry->{target});

        is ($r1->{name}, $r2->{name});
        is ($r1->{category}, $r2->{category});
        is ($r1->{os}, $r2->{os});
        is ($r1->{version}, $r2->{version});
        is ($r1->{vendor}, $r2->{vendor});

        is (Woothee::is_crawler($entry->{target}), Woothee->is_crawler($entry->{target}));
    }
}

my $testset_dir = File::Basename::dirname(__FILE__) . "/testsets/";

subtest 'crawler' => sub { run_testset($testset_dir . "crawler.yaml", "Crawler"); };
subtest 'crawler_google' => sub { run_testset($testset_dir . "crawler_google.yaml", "Crawler/Google"); };
subtest 'pc_windows' => sub { run_testset($testset_dir . "pc_windows.yaml", "PC/Windows"); };
subtest 'pc_misc' => sub { run_testset($testset_dir . "pc_misc.yaml", "PC/Misc"); };
subtest 'mobilephone_docomo' => sub { run_testset($testset_dir . "mobilephone_docomo.yaml", "MobilePhone/docomo"); };
subtest 'mobilephone_au' => sub { run_testset($testset_dir . "mobilephone_au.yaml", "MobilePhone/au"); };
subtest 'mobilephone_softbank' => sub { run_testset($testset_dir . "mobilephone_softbank.yaml", "MobilePhone/softbank"); };
subtest 'mobilephone_willcom' => sub { run_testset($testset_dir . "mobilephone_willcom.yaml", "MobilePhone/willcom"); };
subtest 'mobilephone_misc' => sub { run_testset($testset_dir . "mobilephone_misc.yaml", "MobilePhone/misc"); };
subtest 'smartphone_ios' => sub { run_testset($testset_dir . "smartphone_ios.yaml", "SmartPhone/ios"); };
subtest 'smartphone_android' => sub { run_testset($testset_dir . "smartphone_android.yaml", "SmartPhone/android"); };
subtest 'smartphone_misc' => sub { run_testset($testset_dir . "smartphone_misc.yaml", "SmartPhone/misc"); };
subtest 'appliance' => sub { run_testset($testset_dir . "appliance.yaml", "Appliance"); };
subtest 'pc_lowpriority' => sub { run_testset($testset_dir . "pc_lowpriority.yaml", "PC/LowPriority"); };
subtest 'misc' => sub { run_testset($testset_dir . "misc.yaml", "Misc"); };
subtest 'crawler_nonmajor' => sub { run_testset($testset_dir . "crawler_nonmajor.yaml", "Crawler/NonMajor"); };

done_testing;
