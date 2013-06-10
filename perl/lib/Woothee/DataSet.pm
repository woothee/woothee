package Woothee::DataSet;

use strict;
use warnings;
use Carp;

our (@ISA, @EXPORT_OK);
BEGIN {
    require Exporter;
    our @ISA = qw(Exporter);
    our @EXPORT_OK = qw(dataset const);
}

my $CONST = {
    KEY_LABEL => "label",
    KEY_NAME => "name",
    KEY_TYPE => "type",
    KEY_CATEGORY => "category",
    KEY_OS => "os",
    KEY_VENDOR => "vendor",
    KEY_VERSION => "version",

    TYPE_BROWSER => "browser",
    TYPE_OS => "os",
    TYPE_FULL => "full",

    CATEGORY_PC => "pc",
    CATEGORY_SMARTPHONE => "smartphone",
    CATEGORY_MOBILEPHONE => "mobilephone",
    CATEGORY_CRAWLER => "crawler",
    CATEGORY_APPLIANCE => "appliance",
    CATEGORY_MISC => "misc",

    ATTRIBUTE_NAME => "name",
    ATTRIBUTE_CATEGORY => "category",
    ATTRIBUTE_OS => "os",
    ATTRIBUTE_VENDOR => "vendor",
    ATTRIBUTE_VERSION => "version",

    VALUE_UNKNOWN => "UNKNOWN",

    CATEGORY_LIST => ["pc", "smartphone", "mobilephone", "crawler", "appliance", "misc", "UNKNOWN"],
    ATTRIBUTE_LIST => ["name", "category", "os", "vendor", "version"],
};

sub const {
    my ($klass, $const_name) = @_;
    $const_name = $klass unless $const_name;
    $CONST->{$const_name};
}

my $DATASET = {};
{
    # GENERATED from dataset.yaml at Fri Jun  7 16:09:18 JST 2013 by tagomoris
    my $obj;
    $obj = {label => 'MSIE', name => 'Internet Explorer', type => 'browser'};
    $obj->{vendor} = 'Microsoft';
    $DATASET->{'MSIE'} = $obj;
    $obj = {label => 'Chrome', name => 'Chrome', type => 'browser'};
    $obj->{vendor} = 'Google';
    $DATASET->{'Chrome'} = $obj;
    $obj = {label => 'Safari', name => 'Safari', type => 'browser'};
    $obj->{vendor} = 'Apple';
    $DATASET->{'Safari'} = $obj;
    $obj = {label => 'Firefox', name => 'Firefox', type => 'browser'};
    $obj->{vendor} = 'Mozilla';
    $DATASET->{'Firefox'} = $obj;
    $obj = {label => 'Opera', name => 'Opera', type => 'browser'};
    $obj->{vendor} = 'Opera';
    $DATASET->{'Opera'} = $obj;
    $obj = {label => 'Sleipnir', name => 'Sleipnir', type => 'browser'};
    $obj->{vendor} = 'Fenrir Inc.';
    $DATASET->{'Sleipnir'} = $obj;
    $obj = {label => 'Win', name => 'Windows UNKNOWN Ver', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win'} = $obj;
    $obj = {label => 'Win8', name => 'Windows 8', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win8'} = $obj;
    $obj = {label => 'Win7', name => 'Windows 7', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win7'} = $obj;
    $obj = {label => 'WinVista', name => 'Windows Vista', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'WinVista'} = $obj;
    $obj = {label => 'WinXP', name => 'Windows XP', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'WinXP'} = $obj;
    $obj = {label => 'Win2000', name => 'Windows 2000', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win2000'} = $obj;
    $obj = {label => 'WinNT4', name => 'Windows NT 4.0', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'WinNT4'} = $obj;
    $obj = {label => 'WinMe', name => 'Windows Me', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'WinMe'} = $obj;
    $obj = {label => 'Win98', name => 'Windows 98', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win98'} = $obj;
    $obj = {label => 'Win95', name => 'Windows 95', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Win95'} = $obj;
    $obj = {label => 'WinPhone', name => 'Windows Phone OS', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'WinPhone'} = $obj;
    $obj = {label => 'WinCE', name => 'Windows CE', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'WinCE'} = $obj;
    $obj = {label => 'OSX', name => 'Mac OSX', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'OSX'} = $obj;
    $obj = {label => 'MacOS', name => 'Mac OS Classic', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'MacOS'} = $obj;
    $obj = {label => 'Linux', name => 'Linux', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'Linux'} = $obj;
    $obj = {label => 'BSD', name => 'BSD', type => 'os'};
    $obj->{category} = 'pc';
    $DATASET->{'BSD'} = $obj;
    $obj = {label => 'Android', name => 'Android', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'Android'} = $obj;
    $obj = {label => 'iPhone', name => 'iPhone', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'iPhone'} = $obj;
    $obj = {label => 'iPad', name => 'iPad', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'iPad'} = $obj;
    $obj = {label => 'iPod', name => 'iPod', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'iPod'} = $obj;
    $obj = {label => 'iOS', name => 'iOS', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'iOS'} = $obj;
    $obj = {label => 'BlackBerry', name => 'BlackBerry', type => 'os'};
    $obj->{category} = 'smartphone';
    $DATASET->{'BlackBerry'} = $obj;
    $obj = {label => 'docomo', name => 'docomo', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = 'docomo';
    $obj->{os} = 'docomo';
    $DATASET->{'docomo'} = $obj;
    $obj = {label => 'au', name => 'au by KDDI', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = 'au';
    $obj->{os} = 'au';
    $DATASET->{'au'} = $obj;
    $obj = {label => 'SoftBank', name => 'SoftBank Mobile', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = 'SoftBank';
    $obj->{os} = 'SoftBank';
    $DATASET->{'SoftBank'} = $obj;
    $obj = {label => 'willcom', name => 'WILLCOM', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = 'WILLCOM';
    $obj->{os} = 'WILLCOM';
    $DATASET->{'willcom'} = $obj;
    $obj = {label => 'jig', name => 'jig browser', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = '';
    $obj->{os} = 'jig';
    $DATASET->{'jig'} = $obj;
    $obj = {label => 'emobile', name => 'emobile', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = '';
    $obj->{os} = 'emobile';
    $DATASET->{'emobile'} = $obj;
    $obj = {label => 'SymbianOS', name => 'SymbianOS', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = '';
    $obj->{os} = 'SymbianOS';
    $DATASET->{'SymbianOS'} = $obj;
    $obj = {label => 'MobileTranscoder', name => 'Mobile Transcoder', type => 'full'};
    $obj->{category} = 'mobilephone';
    $obj->{vendor} = '';
    $obj->{os} = 'Mobile Transcoder';
    $DATASET->{'MobileTranscoder'} = $obj;
    $obj = {label => 'Nintendo3DS', name => 'Nintendo 3DS', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Nintendo';
    $obj->{os} = 'Nintendo 3DS';
    $DATASET->{'Nintendo3DS'} = $obj;
    $obj = {label => 'NintendoDSi', name => 'Nintendo DSi', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Nintendo';
    $obj->{os} = 'Nintendo DSi';
    $DATASET->{'NintendoDSi'} = $obj;
    $obj = {label => 'NintendoWii', name => 'Nintendo Wii', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Nintendo';
    $obj->{os} = 'Nintendo Wii';
    $DATASET->{'NintendoWii'} = $obj;
    $obj = {label => 'NintendoWiiU', name => 'Nintendo Wii U', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Nintendo';
    $obj->{os} = 'Nintendo Wii U';
    $DATASET->{'NintendoWiiU'} = $obj;
    $obj = {label => 'PSP', name => 'PlayStation Portable', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Sony';
    $obj->{os} = 'PlayStation Portable';
    $DATASET->{'PSP'} = $obj;
    $obj = {label => 'PSVita', name => 'PlayStation Vita', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Sony';
    $obj->{os} = 'PlayStation Vita';
    $DATASET->{'PSVita'} = $obj;
    $obj = {label => 'PS3', name => 'PlayStation 3', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = 'Sony';
    $obj->{os} = 'PlayStation 3';
    $DATASET->{'PS3'} = $obj;
    $obj = {label => 'DigitalTV', name => 'InternetTVBrowser', type => 'full'};
    $obj->{category} = 'appliance';
    $obj->{vendor} = '';
    $obj->{os} = 'DigitalTV';
    $DATASET->{'DigitalTV'} = $obj;
    $obj = {label => 'SafariRSSReader', name => 'Safari RSSReader', type => 'full'};
    $obj->{category} = 'misc';
    $obj->{vendor} = 'Apple';
    $DATASET->{'SafariRSSReader'} = $obj;
    $obj = {label => 'GoogleDesktop', name => 'Google Desktop', type => 'full'};
    $obj->{category} = 'misc';
    $obj->{vendor} = 'Google';
    $DATASET->{'GoogleDesktop'} = $obj;
    $obj = {label => 'WindowsRSSReader', name => 'Windows RSSReader', type => 'full'};
    $obj->{category} = 'misc';
    $obj->{vendor} = 'Microsoft';
    $DATASET->{'WindowsRSSReader'} = $obj;
    $obj = {label => 'VariousRSSReader', name => 'RSSReader', type => 'full'};
    $obj->{category} = 'misc';
    $obj->{vendor} = '';
    $DATASET->{'VariousRSSReader'} = $obj;
    $obj = {label => 'HTTPLibrary', name => 'HTTP Library', type => 'full'};
    $obj->{category} = 'misc';
    $obj->{vendor} = '';
    $DATASET->{'HTTPLibrary'} = $obj;
    $obj = {label => 'GoogleBot', name => 'Googlebot', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleBot'} = $obj;
    $obj = {label => 'GoogleBotMobile', name => 'Googlebot Mobile', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleBotMobile'} = $obj;
    $obj = {label => 'GoogleMediaPartners', name => 'Google Mediapartners', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleMediaPartners'} = $obj;
    $obj = {label => 'GoogleFeedFetcher', name => 'Google Feedfetcher', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleFeedFetcher'} = $obj;
    $obj = {label => 'GoogleAppEngine', name => 'Google AppEngine', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleAppEngine'} = $obj;
    $obj = {label => 'GoogleWebPreview', name => 'Google Web Preview', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'GoogleWebPreview'} = $obj;
    $obj = {label => 'YahooSlurp', name => 'Yahoo! Slurp', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'YahooSlurp'} = $obj;
    $obj = {label => 'YahooJP', name => 'Yahoo! Japan', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'YahooJP'} = $obj;
    $obj = {label => 'YahooPipes', name => 'Yahoo! Pipes', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'YahooPipes'} = $obj;
    $obj = {label => 'Baiduspider', name => 'Baiduspider', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'Baiduspider'} = $obj;
    $obj = {label => 'msnbot', name => 'msnbot', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'msnbot'} = $obj;
    $obj = {label => 'bingbot', name => 'bingbot', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'bingbot'} = $obj;
    $obj = {label => 'Yeti', name => 'Naver Yeti', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'Yeti'} = $obj;
    $obj = {label => 'FeedBurner', name => 'Google FeedBurner', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'FeedBurner'} = $obj;
    $obj = {label => 'facebook', name => 'facebook', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'facebook'} = $obj;
    $obj = {label => 'mixi', name => 'mixi', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'mixi'} = $obj;
    $obj = {label => 'IndyLibrary', name => 'Indy Library', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'IndyLibrary'} = $obj;
    $obj = {label => 'ApplePubSub', name => 'Apple iCloud', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'ApplePubSub'} = $obj;
    $obj = {label => 'Genieo', name => 'Genieo Web Filter', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'Genieo'} = $obj;
    $obj = {label => 'topsyButterfly', name => 'topsy Butterfly', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'topsyButterfly'} = $obj;
    $obj = {label => 'rogerbot', name => 'SeoMoz rogerbot', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'rogerbot'} = $obj;
    $obj = {label => 'AhrefsBot', name => 'ahref AhrefsBot', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'AhrefsBot'} = $obj;
    $obj = {label => 'radian6', name => 'salesforce radian6', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'radian6'} = $obj;
    $obj = {label => 'Hatena', name => 'Hatena', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'Hatena'} = $obj;
    $obj = {label => 'goo', name => 'goo', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'goo'} = $obj;
    $obj = {label => 'livedoorFeedFetcher', name => 'livedoor FeedFetcher', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'livedoorFeedFetcher'} = $obj;
    $obj = {label => 'VariousCrawler', name => 'misc crawler', type => 'full'};
    $obj->{category} = 'crawler';
    $obj->{vendor} = '';
    $DATASET->{'VariousCrawler'} = $obj;
}

sub dataset {
    my ($klass, $label) = @_;
    $label = $klass unless $label;
    $DATASET->{$label};
}

1;
__END__

=head1 NAME

Woothee::DataSet - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
