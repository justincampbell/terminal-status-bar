NAME := tmux-status-bar
VERSION := v1.0.0

MAIN := main.swift
FILES := $(shell exec find bin -type file)
PREFIX := /usr/local

SWIFT_OPTS := -import-objc-header bridge.h

all: build test

build: bin/
	swiftc -o bin/$(NAME) $(SWIFT_OPTS) $(MAIN)

run:
	swift $(SWIFT_OPTS) $(MAIN) -p -n

test:
	@echo "#TODO"

release: tag
	git push origin
	git push origin --tags

tag:
	git tag --message "Release $(VERSION)" --sign $(VERSION)

install:
	mkdir -p $(BIN)/bin
	for file in $(FILES); do cp -v $$file $(PREFIX)/$$file; done

uninstall:
	for file in $(FILES); do rm -vf $(PREFIX)/$$file; done

bin/:
	mkdir -p $@

.PHONY: all build run test release tag install uninstall
