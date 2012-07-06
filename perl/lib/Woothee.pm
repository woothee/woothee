package Woothee;

use strict;
use warnings;
use Carp;

use Woothee::DataSet;
use Woothee::Browser;
use Woothee::OS;
use Woothee::MobilePhone;
use Woothee::Crawler;
use Woothee::Appliance;
use Woothee::Misc;

our $VERSION = "0.2.1";

sub parse {
    my $useragent = shift;
    return fill_result(exec_parse($useragent));
}

sub is_crawler {
    my $useragent = shift;

    return 0 if not defined($useragent) || length($useragent) < 1 || $useragent eq '-';
    if (try_crawler($useragent, {})) {
        return 1;
    }
    return 0;
}

sub exec_parse {
    my $useragent = shift;
    my $result = {};

    return $result if not defined($useragent) || length($useragent) < 1 || $useragent eq '-';

    if (try_crawler($useragent, $result)) {
        return $result;
    }

    if (try_browser($useragent, $result)) {
        if (try_os($useragent, $result)) {
            return $result;
        }else{
            return $result;
        }
    }

    if (try_mobilephone($useragent, $result)) {
        return $result;
    }

    if (try_appliance($useragent, $result)) {
        return $result;
    }

    if (try_misc($useragent, $result)) {
        return $result;
    }

    # browser unknown. check os only
    if (try_os($useragent, $result)) {
        return $result;
    }

    if (try_rare_cases($useragent, $result)) {
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

sub try_browser {
    my ($useragent, $result) = @_;

    if (Woothee::Browser::challenge_msie($useragent, $result)) {
        return 1;
    }
    if (Woothee::Browser::challenge_safari_chrome($useragent, $result)) {
        return 1;
    }
    if (Woothee::Browser::challenge_firefox($useragent, $result)) {
        return 1;
    }
    if (Woothee::Browser::challenge_opera($useragent, $result)) {
        return 1;
    }

    return 0;
}

sub try_os {
    my ($useragent, $result) = @_;

    # Windows PC, and Windows Phone OS
    if (Woothee::OS::challenge_windows($useragent, $result)) {
        return 1;
    }

    # OSX PC and iOS devices(strict check)
    if (Woothee::OS::challenge_osx($useragent, $result)) {
        return 1;
    }

    # Linux PC, and Android
    if (Woothee::OS::challenge_linux($useragent, $result)) {
        return 1;
    }

    # all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
    if (Woothee::OS::challenge_smartphone($useragent, $result)) {
        return 1;
    }

    # mobile phones like KDDI-.*
    if (Woothee::OS::challenge_mobilephone($useragent, $result)) {
        return 1;
    }

    # Nintendo DSi/Wii with Opera
    if (Woothee::OS::challenge_appliance($useragent, $result)) {
        return 1;
    }

    # Win98, BSD
    if (Woothee::OS::challenge_misc($useragent, $result)) {
        return 1;
    }

    return 0;
}

sub try_mobilephone {
    my ($useragent, $result) = @_;

    if (Woothee::MobilePhone::challenge_docomo($useragent, $result)) {
        return 1;
    }
    if (Woothee::MobilePhone::challenge_au($useragent, $result)) {
        return 1;
    }
    if (Woothee::MobilePhone::challenge_softbank($useragent, $result)) {
        return 1;
    }
    if (Woothee::MobilePhone::challenge_willcom($useragent, $result)) {
        return 1;
    }
    if (Woothee::MobilePhone::challenge_misc($useragent, $result)) {
        return 1;
    }
    return 0;
}

sub try_appliance {
    my ($useragent, $result) = @_;

    if (Woothee::Appliance::challenge_playstation($useragent, $result)) {
        return 1;
    }
    if (Woothee::Appliance::challenge_nintendo($useragent, $result)) {
        return 1;
    }
    if (Woothee::Appliance::challenge_digitaltv($useragent, $result)) {
        return 1;
    }
    return 0;
}

sub try_misc {
    my ($useragent, $result) = @_;

    if (Woothee::Misc::challenge_desktoptools($useragent, $result)) {
        return 1;
    }
    return 0;
}

sub try_rare_cases {
    my ($useragent, $result) = @_;

    if (Woothee::Misc::challenge_smartphone_patterns($useragent, $result)) {
        return 1;
    }
    if (Woothee::Browser::challenge_sleipnir($useragent, $result)) {
        return 1;
    }
    if (Woothee::Misc::challenge_http_library($useragent, $result)) {
        return 1;
    }
    if (Woothee::Misc::challenge_maybe_rss_reader($useragent, $result)) {
        return 1;
    }
    if (Woothee::Crawler::challenge_maybe_crawler($useragent, $result)) {
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
