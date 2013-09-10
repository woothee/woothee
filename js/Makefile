TESTS=test/*.js

all: test

lib/dataset.js: ../dataset.yaml
	perl ../bin/dataset_yaml2js.pl
	sync; sync; sync

release/woothee.js: lib/*.js
	mkdir release || ls -d release
	perl ../bin/jsbuilder.pl

test: lib/dataset.js build
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require should \
		--slow 20 \
		$(TESTS)

build: release/woothee.js

.PHONY: test
