UNAME := $(shell uname)

.PHONY: setup
setup:
ifeq ($(UNAME), Darwin)
	@./macos/setup/bootstrap.sh
	@./macos/setup/osconfig.sh
	@./macos/scripts/sync.sh
endif

.PHONY: link
link:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/stow.sh link
endif

.PHONY: unlink
unlink:
ifeq ($(UNAME), Darwin)
	@./macos/scripts/stow.sh unlink
endif

.PHONY: reconcile
reconcile:
ifeq ($(UNAME), Darwin)
	@brew bundle dump --force && sort Brewfile -o Brewfile
	@code --list-extensions | sort -f > ./manifest/vscode-extensions.txt
	@volta list --format=plain > ./manifest/volta-list.txt
	@cp "~/Library/Application Support/Spectacle/Shortcuts.json" ./macos/manifest/spectacle.json
	@cp ~/.iterm/com.googlecode.iterm2.plist ./macos/home/iterm/
endif

.PHONY: format
format:
ifeq ($(UNAME), Darwin)
	@dos2unix ./scripts/*.sh
	@dos2unix ./macos/scripts/*.sh
	@./scripts/format.sh
endif
