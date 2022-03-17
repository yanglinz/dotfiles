UNAME := $(shell uname)

.PHONY: setup
setup:
ifeq ($(UNAME), Darwin)
	@./scripts/bootstrap.sh
	@./macos/scripts/set-system-config.sh
	@./macos/scripts/copy-root-config.sh
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

.PHONY: drift
drift:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/track-drift.sh
endif

.PHONY: format
format:
ifeq ($(UNAME), Darwin)
	@dos2unix ./scripts/*.sh
	@dos2unix ./macos/scripts/*.sh
	@./scripts/format.sh
endif
