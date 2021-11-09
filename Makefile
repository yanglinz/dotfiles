UNAME := $(shell uname)

.PHONY: setup
setup:
ifeq ($(UNAME), Darwin)
	@./macos/setup/bootstrap.sh
	@./macos/setup/osconfig.sh
	@./macos/scripts/sync.sh
endif

.PHONY: link
link:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/stow.sh link
endif

.PHONY: unlink
unlink:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/stow.sh unlink
endif

.PHONY: reconcile
reconcile:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/reconcile.sh
endif

.PHONY: format
format:
ifeq ($(UNAME), Darwin)
	@dos2unix ./scripts/*.sh
	@dos2unix ./macos/scripts/*.sh
	@./scripts/format.sh
endif
