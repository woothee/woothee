package Woothee;

use strict;
use warnings;
use Carp;

use Woothee::DataSet;
# use Woothee::Browser;
# use Woothee::OS;
# use Woothee::MobilePhone;
use Woothee::Crawler;
# use Woothee::Appliance;
# use Woothee::Misc;

sub parse {
    my $useragent = shift;
    return fill_result(exec_parse($useragent));
}

sub exec_parse {
    my $useragent = shift;
    my $result = {};

    return $result if length($useragent) < 1 || $useragent eq '-';

    if (try_crawler($useragent, $result)) {
        return $result;
    }

    return $result;
}

sub try_crawler {
    my ($useragent, $result) = @_;

    if (Woothee::Crawler::challenge_google($useragent, $result)) {
        return 1;
    }
    if (Woothee::Crawler::challenge_crawlers($useragent, $result)) {
        return 1;
    }
    return 0;
}

my @filled = (
    Woothee::DataSet->const('ATTRIBUTE_NAME') => Woothee::DataSet->const('VALUE_UNKNOWN'),
    Woothee::DataSet->const('ATTRIBUTE_CATEGORY') => Woothee::DataSet->const('VALUE_UNKNOWN'),
    Woothee::DataSet->const('ATTRIBUTE_OS') => Woothee::DataSet->const('VALUE_UNKNOWN'),
    Woothee::DataSet->const('ATTRIBUTE_VERSION') => Woothee::DataSet->const('VALUE_UNKNOWN'),
    Woothee::DataSet->const('ATTRIBUTE_VENDOR') => Woothee::DataSet->const('VALUE_UNKNOWN'),
);
sub fill_result {
    my $result = shift;
    return +{@filled, %$result};
}

1;
