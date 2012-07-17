use strict;
use warnings;
use utf8;
use Test::More;
use File::Find::Rule;
use FindBin;
use File::Spec;

my @files = File::Find::Rule->file()->name('*.pm')->in("$FindBin::Bin/../lib/");
for (@files) {
    $_ = File::Spec->abs2rel($_, "$FindBin::Bin/../lib/");
    s![/\\]!::!g;
    s!\.pm$!!g;
    next if $_ ~~ [qw//];
    use_ok $_;
}

done_testing;
