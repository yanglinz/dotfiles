.PHONY: setup
setup: 
	@./macos/setup/bootstrap.sh
	@./macos/setup/osconfig.sh
	@./macos/scripts/sync.sh

.PHONY: link
link:
	@./macos/scripts/stow.sh link

.PHONY: unlink
unlink:
	@./macos/scripts/stow.sh unlink

.PHONY: reconcile
reconcile:
	@brew bundle dump --force && sort Brewfile -o Brewfile
	@code --list-extensions | sort -f > ./manifest/vscode-extensions.txt
	@volta list --format=plain > ./manifest/volta-list.txt
	@cp "~/Library/Application Support/Spectacle/Shortcuts.json" ./macos/manifest/spectacle.json
	@cp ~/.iterm/com.googlecode.iterm2.plist ./macos/home/.iterm/

.PHONY: format
format:
	@dos2unix ./scripts/*.sh
	@dos2unix ./macos/scripts/*.sh
	@./scripts/format.sh
