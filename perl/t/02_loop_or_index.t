use strict;
use warnings;
use Test::More;

use Time::HiRes qw/gettimeofday/;

my $ua1 = "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";
my $ua2 = "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)";
my $ua3 = "DoCoMo/2.0 P900i(c100;TB;W24H11) (compatible; ichiro/mobile goo; +http://help.goo.ne.jp/help/article/1142/)";
my $ua4 = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; 2004/11/08; GoogleT5; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)";
my $ua5 = "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7";
my $ua6 = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1) Sleipnir/2.8.0";

my $p = qr/Yahoo! Slurp;|YahooFeedSeeker(Beta)?Jp|Yahoo Pipes|msnbot|compatible; bingbot|Yeti|Indy Library|Apple-PubSub|Hatena (Antenna|Pagetitle|Diary RSS)|Baiduspider|ichiro|livedoor FeedFetcher|facebookexternalhit/o;

sub search_regexp {
    my $ua = shift;
    $ua =~ $p;
}

sub search_index {
    my $ua = shift;
    if (index($ua, "Yahoo") > -1) { return 1; }
    elsif (index($ua, "msnbot") > -1) { return 1; }
    elsif (index($ua, "bingbot") > -1) { return 1; }
    elsif (index($ua, "Baidu") > -1) { return 1; }
    elsif (index($ua, "Yeti") > -1) { return 1; }
    elsif (index($ua, "facebookexternalhit") > -1) { return 1; }
    elsif (index($ua, "Apple-PubSub") > -1) { return 1; }
    elsif (index($ua, "livedoor FeedFetcher") > -1) { return 1; }
    elsif (index($ua, "Hatena ") > -1) { return 1; }
    elsif (index($ua, "Indy Library") > -1) { return 1; }
    return 0;
}

subtest 'regexp_pattern' => sub {
    is (1,1);
    return;
    # got: '3292305', 14080000 in java
    my ($start,$ustart) = gettimeofday;
    for (my $i = 0 ; $i < 100000 ; $i++) {
        search_regexp($ua1); search_regexp($ua2); search_regexp($ua3);
        search_regexp($ua4); search_regexp($ua5); search_regexp($ua6);
    }
    my ($end,$uend) = gettimeofday;
    is (($end * 1000000 + $uend) - ($start * 1000000 + $ustart), 1, "regexp_pattern");
};

subtest 'index_pattern' => sub {
    is (1,1);
    return;
    # got: '1761313' in 1060000 in java
    my ($start,$ustart) = gettimeofday;
    for (my $i = 0 ; $i < 100000 ; $i++) {
        search_index($ua1); search_index($ua2); search_index($ua3);
        search_index($ua4); search_index($ua5); search_index($ua6);
    }
    my ($end,$uend) = gettimeofday;
    is (($end * 1000000 + $uend) - ($start * 1000000 + $ustart), 1, "index_pattern");
};

done_testing;
