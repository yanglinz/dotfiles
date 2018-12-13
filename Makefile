.PHONY: presetup
presetup:
	@./scripts/dot.sh setup

.PHONY: postsetup
postsetup:
	@fish ~/.config/fish/post-setup.fish

setup: presetup postsetup

.PHONY: link
link:
	@./scripts/dot.sh link

.PHONY: unlink
unlink:
	@./scripts/dot.sh unlink

.PHONY: sync
sync:
	@./scripts/dot.sh sync

.PHONY: check
check:
	@shellcheck **/*.sh
