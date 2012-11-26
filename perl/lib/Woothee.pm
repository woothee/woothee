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

our $VERSION = "0.3.0";

sub parse {
    my ($this,$useragent) = @_;
    $useragent ||= $this; # called as Woothee::parse()
    return fill_result(exec_parse($useragent));
}

sub is_crawler {
    my ($this,$useragent) = @_;
    $useragent ||= $this; # called as Woothee::is_crawler()

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

__END__

=head1 NAME

Woothee - multi-language user-agent strings parsers (perl implementation)

For Woothee, see https://github.com/tagomoris/woothee

=head1 SYNOPSIS

  use Woothee;

  Woothee->parse("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)");
  # => {'name'=>"Internet Explorer", 'category'=>"pc", 'os'=>"Windows 7", 'version'=>"8.0", 'vendor'=>"Microsoft"}

  Woothee->is_crawler('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');
  # => 1

=head1 DESCRIPTION

'Woothee' is user-agent string parser, returns just same result over multi-language by sharing same datasets and testsets over implementations of each languages.

=head1 METHODS

'Woothee' have no instance methods.

=head2 CLASS METHODS

=head3 C<< Woothee->parse( $useragent ) :HashRef >>

Parse user-agent string and returns HashRef with keys 'name', 'category', 'os', 'version' and 'vendor'.

For unknown user-agent (or partially failed to parse), result hashref may have value 'UNKNOWN'.

=over

=item 'category' is labels of user terminal type, one of 'pc', 'smartphone', 'mobilephone', 'appliance', 'crawler' or 'misc' (or 'UNKNOWN').

=item 'name' is the name of browser, like 'Internet Explorer', 'Firefox', 'GoogleBot'.

=item 'version' is version string, like '8.0' for IE, '9.0.1' for Firefix, '0.2.149.27' for Chrome, and so on.

=item 'os' is like 'Windows 7', 'Mac OSX', 'iPhone', 'iPad', 'Android'. This field used to indicate cellar phone carrier for category 'mobilephone'.

=item 'vendor' is optional field, shows browser vendor.

=back

=head3 C<< Woothee->is_crawler( $useragent ) :Bool >>

Try to see $useragent's category is 'crawler' or not, by casual(fast) method. Minor case of crawler is not tested in this method. To check crawler strictly, use "Woothee->parse()->{category} eq 'crawler'".

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
