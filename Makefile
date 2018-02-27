# NOTE: just for testing, this gets overridden by debuild
BASEVERSION ?= 0.8.1
CHECKSUM := $(shell dpkg-parsechangelog | sed -ne 's/.*SHA256://p')
ARCHIVE := vault_$(BASEVERSION)_linux_amd64.zip
URL := https://releases.hashicorp.com/vault/$(BASEVERSION)/$(ARCHIVE)

all: download

download: $(ARCHIVE) CHANGELOG.md

install: download
	install --mode 0755 vault $(DESTDIR)/usr/bin/
	install --mode 0644 server.hcl $(DESTDIR)/etc/vault/conf.d

clean:
	$(RM) $(ARCHIVE) vault CHANGELOG.md

test: vault
	./vault -v

vault: $(ARCHIVE)
	echo '$(CHECKSUM)  $(ARCHIVE)' | sha256sum -c
	unzip $(ARCHIVE)

$(ARCHIVE):
	wget --no-verbose --no-cookies $(URL)

CHANGELOG.md:
	wget --no-verbose --no-cookies https://github.com/hashicorp/vault/blob/v$(BASEVERSION)/CHANGELOG.md

.PHONY: all download clean test
.DELETE_ON_ERROR:
