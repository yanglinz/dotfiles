.PHONY: setup
setup: 
	@./scripts/setup.sh
	@./scripts/setup.fish

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
