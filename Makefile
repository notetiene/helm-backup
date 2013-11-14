EMACS ?= emacs
EMACS_CLEAN=-Q
EMACS_BATCH=$(EMACS_CLEAN) --batch
CASK=cask
PKG_DIR := $(shell ${CASK} package-directory)

test: unit-tests

unit-tests:
	@echo "-- Running unit-test --"
	${CASK} exec ert-runner

test-travis :
	@echo "-- Testing travis.yml --"
	@if test -z "$$TRAVIS" && test -e $(TRAVIS_FILE); then travis-lint $(TRAVIS_FILE); fi

downloads : download-cask-packages

download-cask-packages:
	@echo "-- Downloading dependencies using cask --"
	${CASK} install

clean: clean-packages

clean-packages:
	@echo "-- Cleaning packages --"
	rm -rf ${PKG_DIR}
