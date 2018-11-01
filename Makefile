.PHONY: setup 
setup:
	@./scripts/dot.sh setup 

.PHONY: link
link:
	@./scripts/dot.sh link

.PHONY: unlink
unlink:
	@./scripts/dot.sh unlink

.PHONY: sync
sync:
	@./scripts/dot.sh sync
