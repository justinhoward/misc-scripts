INSTALL_DIR?=$(HOME)
INSTALL_BIN_DIR?=$(INSTALL_DIR)/bin

SRC_BIN_DIR=bin
SRC_BINS=$(wildcard $(SRC_BIN_DIR)/*)
INSTALLED_BINS=$(patsubst $(SRC_BIN_DIR)/%,$(INSTALL_BIN_DIR)/%,$(SRC_BINS))

.PHONY: install
install: $(INSTALLED_BINS)
$(INSTALL_BIN_DIR)/%: $(SRC_BIN_DIR)/%
	install $< $@

.PHONY: link
link: $(INSTALLED_BINS)
$(INSTALL_BIN_DIR)/%: $(SRC_BIN_DIR)/%
	ln -sf $(realpath $<) $@

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
