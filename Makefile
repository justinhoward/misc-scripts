INSTALL_DIR?=$(HOME)
INSTALL_BIN_DIR?=$(INSTALL_DIR)/bin
INSTALL_LINK?=0

SRC_BIN_DIR=bin
SRC_BINS=$(wildcard $(SRC_BIN_DIR)/*)
INSTALLED_BINS=$(patsubst $(SRC_BIN_DIR)/%,$(INSTALL_BIN_DIR)/%,$(SRC_BINS))

.PHONY: install
install: $(INSTALLED_BINS)
$(INSTALL_BIN_DIR)/%: $(SRC_BIN_DIR)/%
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
	$(info INSTALL_DIR: $(INSTALL_DIR))
	$(info INSTALL_BIN_DIR: $(INSTALL_BIN_DIR))
	$(info SRC_BIN_DIR: $(SRC_BIN_DIR))
	$(info SRC_BINS: $(SRC_BINS))
	$(info INSTALLED_BINS: $(INSTALLED_BINS))
	@true
