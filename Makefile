default: all

LS = node_modules/livescript
LSC = node_modules/.bin/lsc
MOCHA = node_modules/.bin/mocha
MOCHA2 = node_modules/.bin/_mocha
ISTANBUL = node_modules/.bin/istanbul

package.json: package.json.ls
	$(LSC) --compile package.json.ls

index.js: index.ls
	$(LSC) --compile index.ls

.PHONY: build test install loc clean

all: build

build: index.js package.json

test: build
	$(MOCHA) --reporter dot --ui tdd --compilers ls:$(LS)

coverage: build
	$(ISTANBUL) cover $(MOCHA2) -- --reporter dot --ui tdd --compilers ls:$(LS)

install: package.json
	npm install .

loc:
	wc --lines index.ls

clean:
	rm -f ./*.js
	rm -f package.json
