use strict;
use warnings;
use Test::More;

use Woothee::DataSet;

subtest 'const' => sub {
    is (Woothee::DataSet->const('ATTRIBUTE_NAME'), 'name');
};

subtest 'const list' => sub {
    is_deeply (Woothee::DataSet->const('ATTRIBUTE_LIST'), ['name','category','os','vendor','version']);
    is_deeply (Woothee::DataSet->const('CATEGORY_LIST'), ['pc','smartphone','mobilephone','crawler','appliance','misc','UNKNOWN'])
};

subtest 'dataset' => sub {
    my $set = Woothee::DataSet::dataset('GoogleBot');
    is ($set->{name}, 'Googlebot');
};

done_testing;
