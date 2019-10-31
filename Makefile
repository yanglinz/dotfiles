.PHONY: setup
setup: 
	@./boot/init.sh
	@./boot/macos.sh

.PHONY: link
link:
	@go run main.go stow
	@./scripts/sync.sh

.PHONY: unlink
unlink:
	@go run main.go unstow

.PHONY: reconcile
reconcile:
	@brew bundle dump --force
	@pip freeze > stow/shell/etc/tools.requirements.txt
	@code --list-extensions >./stow/vscode/extensions.txt
	@cp ~/.iterm/com.googlecode.iterm2.plist configs/home/.iterm/

.PHONY: format
format:
	@pipenv run black ./scripts
	@pipenv run black stow/shell/bin/profile
	@pipenv run black stow/shell/bin/vscode
	@dos2unix ./scripts/*.sh
	@./scripts/format.sh

.PHONY: check
check:
	@shellcheck -x **/*.sh
