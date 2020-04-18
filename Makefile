PREFIX=/media/jeksterslab/scripts/r
PKG=$(PREFIX)/jeksterslabRutils

.PHONY: all clean

all :
	-rm -rf ${PKG}/docs/*
	-rm -rf ${PKG}/man/*
	-rm -rf ${PKG}/tests/testthat/*.html
	-rm -rf ${PKG}/tests/testthat/*.md
	-rm -rf ${PKG}/vignettes/*.html
	-rm -rf ${PKG}/vignettes/*.md
	Rscript -e 'jeksterslabRpkg::pkg_build("$(PKG)", git = TRUE, github = TRUE)'

clean :
	-rm -rf ${PKG}/docs/*
	-rm -rf ${PKG}/man/*
	-rm -rf ${PKG}/tests/testthat/*.html
	-rm -rf ${PKG}/tests/testthat/*.md
	-rm -rf ${PKG}/vignettes/*.html
	-rm -rf ${PKG}/vignettes/*.md
	git add --all
	git commit -m "Automated clean."
	git push
