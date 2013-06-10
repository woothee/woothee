package Woothee::Misc;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

our $VERSION = "0.3.2";

sub challenge_desktoptools {
    my ($ua, $result) = @_;

    my $data;

    if (index($ua, "AppleSyndication/") > -1) {
        $data = dataset("SafariRSSReader");
    }
    elsif (index($ua, "compatible; Google Desktop/") > -1) {
        $data = dataset("GoogleDesktop");
    }
    elsif (index($ua, "Windows-RSS-Platform") > -1) {
        $data = dataset("WindowsRSSReader");
    }

    return 0 unless $data;

    update_map($result, $data);
    return 1;
}

sub challenge_smartphone_patterns {
    my ($ua, $result) = @_;

    if (index($ua, "CFNetwork/") > -1) {
        my $data = dataset("iOS");
        update_category($result, $data->{Woothee::DataSet->const('KEY_CATEGORY')});
        update_os($result, $data->{Woothee::DataSet->const('KEY_NAME')});
        return 1;
    }

    return 0;
}

sub challenge_http_library {
    my ($ua, $result) = @_;

    my $data;
    my $version;

    if ($ua =~ m{^(?:Apache-HttpClient/|Jakarta Commons-HttpClient/|Java/)}o || $ua =~ m{[- ]HttpClient(/|$)}o) {
        $data = dataset("HTTPLibrary");
        $version = "Java";
    }
    elsif (index($ua, "Java(TM) 2 Runtime Environment,") > -1) {
        $data = dataset("HTTPLibrary");
        $version = "Java";
    }
    elsif ($ua =~ m{^Wget/}o) {
        $data = dataset("HTTPLibrary");
        $version = "wget";
    }
    elsif ($ua =~ m{^(?:libwww-perl|WWW-Mechanize|LWP::Simple|LWP |lwp-trivial)}o) {
        $data = dataset("HTTPLibrary");
        $version = "perl";
    }
    elsif ($ua =~ m{^(?:Ruby|feedzirra|Typhoeus)}o) {
        # for feedzirra, see http://github.com/pauldix/feedzirra/tree/master
        # for Typhoeus, see https://github.com/typhoeus/typhoeus
        $data = dataset("HTTPLibrary");
        $version = "ruby";
    }
    elsif ($ua =~ m{^(?:Python-urllib/|Twisted )}o) {
        $data = dataset("HTTPLibrary");
        $version = "python";
    }
    elsif ($ua =~ m{^(?:PHP|WordPress|CakePHP|PukiWiki|PECL::HTTP)(?:/| |$)}o || $ua =~ m{(?:PEAR |)HTTP_Request(?: class|2)}o) {
        $data = dataset("HTTPLibrary");
        $version = "php";
    }

    return 0 unless $data;

    update_map($result, $data);
    update_version($result, $version) if defined $version;
    return 1;
}

sub challenge_maybe_rss_reader {
    my ($ua, $result) = @_;

    my $data;

    if ($ua =~ m{rss(?:reader|bar|[-_ /;()]|[ +]*/)}oi || $ua =~ m{headline-reader}oi) {
        $data = dataset("VariousRSSReader");
    }
    elsif (index($ua, "cococ/") > -1) {
        $data = dataset("VariousRSSReader");
    }

    return 0 unless $data;

    update_map($result, $data);
    return 1;
}

1;

__END__

=head1 NAME

Woothee::Misc - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
