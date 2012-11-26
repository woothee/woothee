TESTS=test/*.js

all: build

lib/dataset.js: ../dataset.yaml
	perl ../bin/dataset_yaml2js.pl
	sync; sync; sync

test: lib/dataset.js
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require should \
		--slow 20 \
		$(TESTS)

build: test
	mkdir release || ls -d release
	perl ../bin/jsbuilder.pl

.PHONY: test
