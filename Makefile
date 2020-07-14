all: prep install

help:
	@echo "Run 'make install' to install, 'make uninstall' to uninstall and 'make prep' to prepare for git push."

prep: thumbnail README.md thumbnail.1.gz

install: thumbnail thumbnail.1.gz
	@echo install
	@bash install.sh
	@bash install.sh -d

uninstall:
	@echo uninstall
	@bash install.sh -u


thumbnail: prep/thumbnail prep/thumbnail.meta
	@echo thumbnail
	@bash makedoc.sh help > thumbnail

README.md: prep/README.md prep/thumbnail.meta
	@echo README.md
	@bash makedoc.sh readme > README.md

thumbnail.1.gz: prep/thumbnail.1 prep/thumbnail.meta
	@echo thumbnail.1.gz
	@bash makedoc.sh man | gzip -c > thumbnail.1.gz
