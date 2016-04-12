HOMEPAGE=https://github.com/justincampbell/tmux-status-bar
PREFIX=/usr/local

VERSION=1.0.0
TAG=v$(VERSION)

ARCHIVE=tmux-status-bar-$(TAG).tar.gz
ARCHIVE_URL=$(HOMEPAGE)/archive/$(TAG).tar.gz
FILES=`find bin -type file`

export PATH := bin:$(PATH)

test:
	TODO

release: tag sha

tag:
	git tag | grep $(TAG) || git tag --message "Release $(TAG)" --sign $(TAG)
	git push origin
	git push origin --tags

install:
	mkdir -p $(PREFIX)/bin
	for file in $(FILES); do cp -v $$file $(PREFIX)/$$file; done

uninstall:
	for file in $(FILES); do rm -vf $(PREFIX)/$$file; done

.PHONY: test release tag sha install uninstall
