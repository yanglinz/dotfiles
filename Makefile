.PHONY: setup
setup: 
	@./scripts/setup.sh
	@./scripts/setup.fish
	@./scripts/macos.sh

.PHONY: link
link:
	@pipenv run ./cli.py link

.PHONY: unlink
unlink:
	@pipenv run ./cli.py unlink

.PHONY: sync
sync:
	@./scripts/link.sh sync

.PHONY: format
format:
	@dos2unix ./scripts/**/*.sh
	@./scripts/format.sh
	@pipenv run black scripts

.PHONY: check
check:
	@shellcheck -x **/*.sh
