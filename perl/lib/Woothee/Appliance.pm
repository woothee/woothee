package Woothee::Appliance;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

our $VERSION = "0.2.4";

sub challenge_playstation {
    my ($ua, $result) = @_;

    my $data;

    if (index($ua, "PSP (PlayStation Portable);") > -1) {
        $data = dataset("PSP");
    }
    elsif (index($ua, "PlayStation Vita") > -1) {
        $data = dataset("PSVita");
    }
    elsif (index($ua, "PLAYSTATION 3;") > -1) {
        $data = dataset("PS3");
    }

    return 0 unless $data;

    update_map($result, $data);
    return 1;
}

sub challenge_nintendo {
    my ($ua, $result) = @_;

    my $data;

    if (index($ua, "Nintendo 3DS;") > -1) {
        $data = dataset("Nintendo3DS");
    }
    elsif (index($ua, "Nintendo DSi;") > -1) {
        $data = dataset("NintendoDSi");
    }
    elsif (index($ua, "Nintendo Wii;") > -1) {
        $data = dataset("NintendoWii");
    }

    return 0 unless $data;

    update_map($result, $data);
    return 1;
}

sub challenge_digitaltv {
    my ($ua, $result) = @_;

    my $data;

    if (index($ua, "InettvBrowser/") > -1) {
        $data = dataset("DigitalTV");
    }

    return 0 unless $data;

    update_map($result, $data);
    return 1;
}

1;

__END__

=head1 NAME

Woothee::Appliance - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
