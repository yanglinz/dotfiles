.PHONY: setup
setup: 
	@./scripts/setup.sh
	@./scripts/fonts.sh
	@./scripts/setup.fish
	@./scripts/macos.sh
	@pipenv install

.PHONY: link
link:
	@pipenv run ./cli.py link
	@./scripts/sync.sh

.PHONY: unlink
unlink:
	@pipenv run ./cli.py unlink

.PHONY: reconcile
reconcile:
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
