REPORTER = spec
NODEARGS = --harmony-generators

test: clean
	@./node_modules/.bin/jshint ./**/*.js --config .jshintrc &2> /dev/null
	@if [ ! -n "$(NODE_ENV)" ]; then \
		NODE_ENV=test NODE_PATH=lib nodemon --exec "./node_modules/.bin/mocha -R $(REPORTER) -t 15000 --recursive" test/suite $(NODEARGS) ; \
	else  \
		NODE_PATH=lib mocha -R $(REPORTER) -t 15000 --recursive test $(NODEARGS) ; \
	fi

clean:
	@if [ ! -n "$(NODE_ENV)" ]; then \
		echo FLUSHDB | redis-cli -n 2; \
		mongo mediaplugin-test --eval "db.dropDatabase()"; \
	fi;


.PHONY: jshint test clean
