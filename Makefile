.PHONY: setup
setup: 
	@./macos/setup/bootstrap.sh
	@./macos/setup/osconfig.sh
	@./scripts/sync.sh

.PHONY: link
link:
	@./scripts/stow.sh link

.PHONY: unlink
unlink:
	@./scripts/stow.sh unlink

.PHONY: reconcile
reconcile:
	@brew bundle dump --force && sort Brewfile -o Brewfile
	@code --list-extensions | sort -f > ./configs/manifest/vscode-extensions.txt
	@volta list --format=plain > ./configs/manifest/volta-list.txt
	#@cp ~/.iterm/com.googlecode.iterm2.plist configs/home/.iterm/

.PHONY: format
format:
	@dos2unix ./scripts/*.sh
	@./scripts/format.sh
