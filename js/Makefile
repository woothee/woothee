TESTS=test/*.js

lib/dataset.js: ../dataset.yaml
	perl ../bin/dataset_yaml2js.pl
	sync; sync; sync

test:
	@NODE_ENV=test ./node_modules/.bin/mocha \
		--require should \
		--slow 20 \
		$(TESTS)

.PHONY: test
