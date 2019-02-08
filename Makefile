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
	@brew bundle dump --force
	@code --list-extensions >./stow/vscode/extensions.txt

.PHONY: format
format:
	@pipenv run black scripts
	@./scripts/format.sh
	@dos2unix ./scripts/**/*.sh

.PHONY: check
check:
	@shellcheck -x **/*.sh
