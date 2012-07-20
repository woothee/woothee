package Woothee::Crawler;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

use 5.010_000;

our $VERSION = "0.2.4";

sub challenge_google {
    my ($ua,$result) = @_;

    return 0 if index($ua, "Google") < 0;

    if (index($ua, "compatible; Googlebot") > -1 ) {
        if (index($ua, "compatible; Googlebot-Mobile") > -1) {
            update_map($result, dataset('GoogleBotMobile'));
            return 1;
        }
        else {
            update_map($result, dataset('GoogleBot'));
            return 1;
        }
    }
    if (index($ua, "Googlebot-Image/") > -1) {
        update_map($result, dataset('GoogleBot'));
        return 1;
    }
    if (index($ua, "Mediapartners-Google") > -1) {
        if (index($ua, "compatible; Mediapartners-Google") > -1 || $ua eq "Mediapartners-Google") {
            update_map($result, dataset('GoogleMediaPartners'));
            return 1;
        }
    }
    if (index($ua, "Feedfetcher-Google;") > -1) {
        update_map($result, dataset("GoogleFeedFetcher"));
        return 1;
    }
    if (index($ua, "AppEngine-Google") > -1) {
        update_map($result, dataset('GoogleAppEngine'));
        return 1;
    }
    if (index($ua, "Google Web Preview") > -1) {
        update_map($result, dataset('GoogleWebPreview'));
        return 1;
    }

    return 0;
}

sub challenge_crawlers {
    my ($ua,$result) = @_;

    if (index($ua, "Yahoo") > -1 || index($ua, "listing.yahoo.co.jp/support/faq/") > -1) {
        if (index($ua, "compatible; Yahoo! Slurp;") > -1) {
            update_map($result, dataset("YahooSlurp"));
            return 1;
        }
        elsif (index($ua, "YahooFeedSeekerJp") > -1 || index($ua, "YahooFeedSeekerBetaJp") > -1) {
            update_map($result, dataset("YahooJP"));
            return 1;
        }
        elsif (index($ua, "crawler (http://listing.yahoo.co.jp/support/faq/") > -1) {
            update_map($result, dataset("YahooJP"));
            return 1;
        }
        elsif (index($ua, "Yahoo Pipes") > -1) {
            update_map($result, dataset("YahooPipes"));
            return 1;
        }
    }
    elsif (index($ua, "msnbot") > -1) {
        update_map($result, dataset("msnbot"));
        return 1;
    }
    elsif (index($ua, "bingbot") > -1) {
        if (index($ua, "compatible; bingbot") > -1) {
            update_map($result, dataset("bingbot"));
            return 1;
        }
    }
    elsif (index($ua, "Baidu") > -1) {
        if (index($ua, "compatible; Baiduspider") > -1 || index($ua, "Baiduspider+") > -1 || index($ua, "Baiduspider-image+") > -1) {
            update_map($result, dataset("Baiduspider"));
            return 1;
        }
    }
    elsif (index($ua, "Yeti") > -1) {
        if (index($ua, "http://help.naver.com/robots") > -1) {
            update_map($result, dataset("Yeti"));
            return 1;
        }
    }
    elsif (index($ua, "FeedBurner/") > -1) {
        update_map($result, dataset("FeedBurner"));
        return 1;
    }
    elsif (index($ua, "facebookexternalhit") > -1) {
        update_map($result, dataset("facebook"));
        return 1;
    }
    elsif (index($ua, "ichiro") > -1) {
        if (index($ua, "http://help.goo.ne.jp/door/crawler.html") > -1 || index($ua, "compatible; ichiro/mobile goo;") > -1) {
            update_map($result, dataset("gooIchiro"));
            return 1;
        }
    }
    elsif (index($ua, "Apple-PubSub") > -1) {
        update_map($result, dataset("ApplePubSub"));
        return 1;
    }
    elsif (index($ua, "livedoor FeedFetcher") > -1 || index($ua, "Fastladder FeedFetcher") > -1) {
        update_map($result, dataset("livedoorFeedFetcher"));
        return 1;
    }
    elsif (index($ua, "Hatena ") > -1) {
        if (index($ua, "Hatena Antenna") > -1 || index($ua, "Hatena Pagetitle Agent") > -1 || index($ua, "Hatena Diary RSS") > -1) {
            update_map($result, dataset("Hatena"));
            return 1;
        }
    }
    elsif (index($ua, "mixi-check") > -1 || index($ua, "mixi-news-crawler") > -1) {
        update_map($result, dataset("mixi")); 
        return 1;
    }
    elsif (index($ua, "Indy Library") > -1) {
        if (index($ua, "compatible; Indy Library") > -1) {
            update_map($result, dataset("IndyLibrary"));
            return 1;
      }
    }

    return 0;

}

sub challenge_maybe_crawler {
    my ($ua, $result) = @_;

    if ($ua =~ m{bot(?:[-_ ./;@()]|$)}oi) {
        update_map($result, dataset("VariousCrawler"));
        return 1;
    }
    if ($ua =~ m{^(?:Rome Client |UnwindFetchor/|ia_archiver |Summify |PostRank/)}o
            or index($ua, "ASP-Ranker Feed Crawler") > -1) {
        update_map($result, dataset("VariousCrawler"));
        return 1;
    }
    if ($ua =~ m{(feed|web) ?parser}oi) {
        update_map($result, dataset("VariousCrawler"));
        return 1;
    }
    if ($ua =~ m{watch ?dog}oi) {
        update_map($result, dataset("VariousCrawler"));
        return 1;
    }

    return 0;
}

1;

__END__

=head1 NAME

Woothee::Crawler - part of Woothee

For Woothee, see https://github.com/tagomoris/woothee

=head1 DESCRIPTION

This module doesn't have any public interfaces. To parse user-agent strings, see module 'Woothee'.

=head1 AUTHOR

TAGOMORI Satoshi E<lt>tagomoris {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
