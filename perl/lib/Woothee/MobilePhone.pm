package Woothee::MobilePhone;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

our $VERSION = "0.3.0";

sub challenge_docomo {
    my ($ua, $result) = @_;

    return 0 if (index($ua, "DoCoMo") < 0 and index($ua, ";FOMA;") < 0);

    my $version;
    if ($ua =~ m{DoCoMo/[.0-9]+[ /]([^- /;()"']+)}o) {
        $version = $1;
    }
    elsif ($ua =~ m{\(([^;)]+);FOMA;}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("docomo"));
    update_version($result, $version);
    return 1;
}

sub challenge_au {
    my ($ua, $result) = @_;

    return 0 if index($ua, "KDDI-") < 0;

    my $version;
    # fix Woothee::OS::challenge_mobile if you want to fix here
    if ($ua =~ m{KDDI-([^- /;()"']+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("au"));
    update_version($result, $version);
    return 1;
}

sub challenge_softbank {
    my ($ua, $result) = @_;

    return 0 if index($ua, "SoftBank") < 0 and index($ua, "Vodafone") < 0 and index($ua, "J-PHONE") < 0;

    my $version;
    if ($ua =~ m{(?:SoftBank|Vodafone|J-PHONE)/[.0-9]+/([^ /;()]+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("SoftBank"));
    update_version($result, $version);
    return 1;
}

sub challenge_willcom {
    my ($ua, $result) = @_;

    return 0 if index($ua, "WILLCOM") < 0 and index($ua, "DDIPOCKET") < 0;

    my $version;
    # fix Woothee::OS::challenge_mobile if you want to fix here
    if ($ua =~ m{(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("willcom"));
    update_version($result, $version);
    return 1;
}

sub challenge_misc {
    my ($ua, $result) = @_;

    if (index($ua, "jig browser") > -1) {
        update_map($result, dataset("jig"));
        if ($ua =~ m{jig browser[^;]+; ([^);]+)}o) {
            update_version($result, $1);
        }
        return 1;
    }
    if (index($ua, "emobile/") > -1 || index($ua, "OpenBrowser") > -1 || index($ua, "Browser/Obigo-Browser") > -1) {
        update_map($result, dataset("emobile"));
        return 1;
    }
    if (index($ua, "SymbianOS") > -1) {
        update_map($result, dataset("SymbianOS"));
        return 1;
    }
    if (index($ua, "Hatena-Mobile-Gateway/") > -1) {
        update_map($result, dataset("MobileTranscoder"));
        update_version($result, "Hatena");
        return 1;
    }
    if (index($ua, "livedoor-Mobile-Gateway/") > -1) {
        update_map($result, dataset("MobileTranscoder"));
        update_version($result, "livedoor");
        return 1;
    }

    return 0;
}

1;

__END__

=head1 NAME

Woothee::MobilePhone - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
