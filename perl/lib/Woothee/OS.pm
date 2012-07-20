package Woothee::OS;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

use 5.010_000;

our $VERSION = "0.2.4";

sub challenge_windows {
    my ($ua, $result) = @_;

    return 0 if index($ua, "Windows") < 0;

    my $data = dataset("Win");

    unless ($ua =~ /Windows ([ .a-zA-Z0-9]+)[;\\)]/o) {
        # Windows, but version unknown
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
        return 1;
    }

    my $version = $1;
    if ($version eq "NT 6.2") { $data = dataset("Win8"); }
    elsif ($version eq "NT 6.1") { $data = dataset("Win7"); }
    elsif ($version eq "NT 6.0") { $data = dataset("WinVista"); }
    elsif ($version eq "NT 5.1") { $data = dataset("WinXP"); }
    elsif ($version =~ /^Phone OS/o) { $data = dataset("WinPhone"); }
    elsif ($version eq "NT 5.0") { $data = dataset("Win2000"); }
    elsif ($version eq "NT 4.0") { $data = dataset("WinNT4"); }
    elsif ($version eq "98") { $data = dataset("Win98"); } # wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
    elsif ($version eq "95") { $data = dataset("Win95"); }
    elsif ($version eq "CE") { $data = dataset("WinCE"); }

    # else, windows, but version unknown

    update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
    update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
    return 1;
}

sub challenge_osx {
    my ($ua, $result) = @_;

    return 0 if index($ua, "Mac OS X") < 0;

    my $data = dataset("OSX");
    if (index($ua, "like Mac OS X") > -1) {
        if (index($ua, "iPhone;") > -1) {
            $data = dataset("iPhone");
        }elsif (index($ua, "iPad;") > -1) {
            $data = dataset("iPad");
        }elsif (index($ua, "iPod;") > -1) {
            $data = dataset("iPod");
        }
    }
    update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
    update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
    return 1;
}

sub challenge_linux {
    my ($ua, $result) = @_;

    return 0 if index($ua, "Linux") < 0;

    my $data;
    if (index($ua, "Android") > -1 ) {
        $data = dataset("Android");
    }else {
        $data = dataset("Linux");
    }
    update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
    update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
    return 1;
}

sub challenge_smartphone {
    my ($ua, $result) = @_;

    my $data;
    if (index($ua, "iPhone") > -1) {
        $data = dataset("iPhone");
    } elsif (index($ua, "iPad") > -1) {
        $data = dataset("iPad");
    } elsif (index($ua, "iPod") > -1) {
        $data = dataset("iPod");
    } elsif (index($ua, "Android") > -1) {
        $data = dataset("Android");
    } elsif (index($ua, "CFNetwork") > -1) {
        $data = dataset("iOS");
    } elsif (index($ua, "BlackBerry") > -1) {
        $data = dataset("BlackBerry");
    }

    return 0 unless $data;

    update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
    update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
    return 1;
}

sub challenge_mobilephone {
    my ($ua, $result) = @_;

    if (index($ua, "KDDI-") > -1) {
        if ($ua =~ m{KDDI-([^- /;()"']+)}o) {
            my $term = $1;
            my $data = dataset("au");
            update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
            update_os($result, $data->{Woothee::DataSet->const('KEY_OS')});
            update_version($result, $term);
            return 1;
        }
    }
    if (index($ua, "WILLCOM") > -1 || index($ua, "DDIPOCKET") > -1) {
        if ($ua =~ m{(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)}o) {
            my $term = $1;
            my $data = dataset("willcom");
            update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
            update_os($result, $data->{Woothee::DataSet->const('KEY_OS')});
            update_version($result, $term);
            return 1;
        }
    }
    if (index($ua, "SymbianOS") > -1) {
        my $data = dataset("SymbianOS");
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_OS')});
        return 1;
    }
    if (index($ua, "Google Wireless Transcoder") > -1) {
        update_map($result, dataset("MobileTranscoder"));
        update_version($result, "Google");
        return 1;
    }
    if (index($ua, "Naver Transcoder") > -1) {
        update_map($result, dataset("MobileTranscoder"));
        update_version($result, "Naver");
        return 1;
    }

    return 0;
}

sub challenge_appliance {
    my ($ua, $result) = @_;

    if (index($ua, "Nintendo DSi;") > -1) {
        my $data = dataset("NintendoDSi");
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_OS')});
        return 1;
    }
    if (index($ua, "Nintendo Wii;") > -1) {
        my $data = dataset("NintendoWii");
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_OS')});
        return 1;
    }

    return 0;
}

sub challenge_misc {
    my ($ua, $result) = @_;

    my $data;

    if (index($ua, "(Win98;") > -1) {
        $data = dataset("Win98");
    }
    elsif (index($ua, "Macintosh; U; PPC;") > -1 || index($ua, "Mac_PowerPC") > -1) {
        $data = dataset("MacOS");
    }
    elsif (index($ua, "X11; FreeBSD ") > -1) {
        $data = dataset("BSD");
    }

    if ($data) {
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
        return 1;
    }

    return 0;
}

1;

__END__

=head1 NAME

Woothee::OS - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
