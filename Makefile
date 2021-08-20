.PHONY: setup
setup: 
	@./boot/init.sh
	@./boot/macos.sh

.PHONY: link
link:
	@deno run ./scripts/stow.ts link

.PHONY: unlink
unlink:
	@go run main.go unstow

.PHONY: reconcile
reconcile:
	@brew bundle dump --force
	@code --list-extensions >./stow/vscode/extensions.txt
	@cp ~/.iterm/com.googlecode.iterm2.plist configs/home/.iterm/

.PHONY: format
format:
	@dos2unix ./scripts/*.sh
	@./scripts/format.sh

.PHONY: check
check:
	@shellcheck -x **/*.sh
