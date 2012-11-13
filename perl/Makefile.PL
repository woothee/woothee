use inc::Module::Install;
name 'Woothee';
all_from 'lib/Woothee.pm';

tests 't/*.t';
test_requires 'YAML';
test_requires 'Test::More';
test_requires 'Test::More';
test_requires 'File::Find::Rule';
test_requires 'FindBin';
test_requires 'File::Spec';
test_requires 'Path::Class';
test_requires 'Time::HiRes';

auto_set_repository;

WriteAll;
