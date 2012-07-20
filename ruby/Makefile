all: test

TIMESTAMP=$(shell date +%Y%m%d-%H%M%S)

checkyaml:
	perl ../bin/dataset_checker.pl

lib/woothee/dataset.rb: ../dataset.yaml
	ruby ../bin/dataset_yaml2rb.rb
	sync; sync; sync

test: lib/woothee/dataset.rb
	rspec spec
