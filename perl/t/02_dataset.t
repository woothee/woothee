use strict;
use warnings;
use Test::More;

use Woothee::DataSet;

subtest 'const' => sub {
    is (Woothee::DataSet->const('ATTRIBUTE_NAME'), 'name');
};

subtest 'dataset' => sub {
    my $set = Woothee::DataSet::dataset('GoogleBot');
    is ($set->{name}, 'Googlebot');
};

done_testing;
