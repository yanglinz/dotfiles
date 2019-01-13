.PHONY: setup
setup: 
	@./scripts/setup.sh
	@./scripts/setup.fish

.PHONY: link
link:
	@./scripts/link.sh link

.PHONY: unlink
unlink:
	@./scripts/link.sh unlink

.PHONY: sync
sync:
	@./scripts/link.sh sync

.PHONY: format
format:
	@dos2unix ./scripts/**/*.sh

.PHONY: check
check:
	@shellcheck -x **/*.sh
