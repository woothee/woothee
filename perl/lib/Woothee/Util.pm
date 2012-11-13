package Woothee::Util;

use strict;
use warnings;
use Carp;

use Woothee::DataSet;

our $VERSION = "0.2.4";

our (@ISA, @EXPORT_OK);
BEGIN {
    require Exporter;
    our @ISA = qw(Exporter);
    our @EXPORT_OK = qw(update_map update_category update_version update_os);
}

sub update_map {
    my ($target,$source) = @_;
    foreach my $key (%$source) {
        next if $key eq Woothee::DataSet->const('KEY_LABEL') or $key eq Woothee::DataSet->const('KEY_TYPE');
        if (defined($source->{$key}) and length($source->{$key}) > 0) {
            $target->{$key} = $source->{$key};
        }
    }
}

sub update_category {
    my ($target,$category) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_CATEGORY')} = $category;
}

sub update_version {
    my ($target,$version) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_VERSION')} = $version;
}

sub update_os {
    my ($target,$os) = @_;
    $target->{Woothee::DataSet->const('ATTRIBUTE_OS')} = $os;
}

1;

__END__

=head1 NAME

Woothee::Util - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
