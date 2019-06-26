.PHONY: setup
setup: 
	@./scripts/setup.sh
	# @./scripts/fonts.sh
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
	@pip freeze > stow/shell/etc/tools.requirements.txt
	@code --list-extensions >./stow/vscode/extensions.txt

.PHONY: format
format:
	@pipenv run black ./scripts
	@pipenv run black stow/shell/bin/profile
	@pipenv run black stow/shell/bin/vscode
	@dos2unix ./scripts/**/*.sh
	@./scripts/format.sh

.PHONY: check
check:
	@shellcheck -x **/*.sh
