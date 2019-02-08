.PHONY: setup
setup: 
	@./scripts/setup.sh
	@./scripts/setup.fish
	@./scripts/macos.sh

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
	@./scripts/format.sh
	@pipenv black scripts

.PHONY: check
check:
	@shellcheck -x **/*.sh
