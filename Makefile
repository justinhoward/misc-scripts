##misc-scripts
##───────────────────────────────────────────────────────────────────────
##Run "make install" to install binaries to ~/bin
##
##To select specific binaries, use BINS. For example: "make install BINS='rngen ssmc'"
##
##To install to another location, use PREFIX or BINDIR. For example:
##"make install PREFIX=/usr/local"

PREFIX?=$(HOME)## The prefix to install to
BINDIR?=$(PREFIX)/bin## The directory to install binaries to
INSTALL_LINK?=0## Create symlinks to the original location instead of copying
BINS?=## Select binary names to install (default is to install all)

SRC_BIN_DIR=bin
ifeq ($(BINS),)
	SRC_BINS=$(wildcard $(SRC_BIN_DIR)/*)
else
	SRC_BINS=$(addprefix $(SRC_BIN_DIR)/,$(BINS))
endif
INSTALLED_BINS=$(patsubst $(SRC_BIN_DIR)/%,$(BINDIR)/%,$(SRC_BINS))

.PHONY: install
install: $(INSTALLED_BINS) ## Install selected binaries
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
info: ## Display configuration information
	$(info PREFIX: $(PREFIX))
	$(info BINDIR: $(BINDIR))
	$(info SRC_BIN_DIR: $(SRC_BIN_DIR))
	$(info SRC_BINS: $(SRC_BINS))
	$(info INSTALLED_BINS: $(INSTALLED_BINS))
	@true

.PHONY: help
.DEFAULT_GOAL := help
# Credit to https://github.com/IllustratedMan-code/make-help
help: ## Show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"

