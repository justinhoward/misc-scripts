PREFIX?=$(HOME)
BINDIR?=$(PREFIX)/bin
INSTALL_LINK?=0

SRC_BIN_DIR=bin
ifdef BINS
	SRC_BINS=$(addprefix $(SRC_BIN_DIR)/,$(BINS))
else
	SRC_BINS=$(wildcard $(SRC_BIN_DIR)/*)
endif
INSTALLED_BINS=$(patsubst $(SRC_BIN_DIR)/%,$(BINDIR)/%,$(SRC_BINS))

.PHONY: install
install: $(INSTALLED_BINS)
$(BINDIR)/%: $(SRC_BIN_DIR)/%
ifeq ($(INSTALL_LINK),1)
	ln -sf $(realpath $<) $@
else
	install $< $@
endif

.PHONY: link
link:
	$(MAKE) install INSTALL_LINK=1

.PHONY: uninstall
uninstall:
	rm -f $(INSTALLED_BINS)

.PHONY: info
info:
	$(info PREFIX: $(PREFIX))
	$(info BINDIR: $(BINDIR))
	$(info SRC_BIN_DIR: $(SRC_BIN_DIR))
	$(info SRC_BINS: $(SRC_BINS))
	$(info INSTALLED_BINS: $(INSTALLED_BINS))
	@true
