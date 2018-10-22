.PHONE: init
init:
	@./scripts/init.sh

.PHONY: link
link:
	@./scripts/dot.sh link

.PHONY: unlink
unlink:
	@./scripts/dot.sh unlink
