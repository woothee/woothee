test: java perl ruby js python

java:
	cd java && ant test

perl:
	cd perl && cpanm -n --installdeps . && $(MAKE) -f Makefile.make test

ruby:
	cd ruby && bundle && $(MAKE) test

python:
	cd python && $(MAKE) test

js:
	cd js && npm install && $(MAKE) test

.PHONY: java perl ruby python js

