MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: run

deps:
	mix deps.get
	mix deps.compile

compile:
	mix compile

run:
	iex -S mix run

test:
	mix test

clean:
	mix clean --all
	mix deps.clean --all

.PHONY: all deps compile run test clean
