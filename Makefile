SPECFILE = nagios-plugins-globus.spec
PROBES=src/GRAM-probe src/GridFTP-probe src/GridProxy-probe src/MyProxy-probe src/refresh_proxy src/CertLifetime-probe 

rpmtopdir := $(shell rpm --eval %_topdir)
rpmbuild  := $(shell [ -x /usr/bin/rpmbuild ] && echo rpmbuild || echo rpm)

PKGNAME = $(shell grep -s '^Name:'    $(SPECFILE) | sed -e 's/Name: *//')
PKGVERS = $(shell grep -s '^Version:' $(SPECFILE) | sed -e 's/Version: *//')

distdir = dist/$(PKGNAME)-$(PKGVERS)

sources: dist $(SPECFILE)
	cd dist && tar cvfz ../$(PKGNAME)-$(PKGVERS).tgz $(PKGNAME)-$(PKGVERS)/*

rpm: dist $(SPECFILE)
	mkdir -p $(rpmtopdir)/{SOURCES,SPECS,BUILD,SRPMS,RPMS}
	cd dist && tar cvfz $(rpmtopdir)/SOURCES/$(PKGNAME)-$(PKGVERS).tgz $(PKGNAME)-$(PKGVERS)/*
	cp -f $(SPECFILE) $(rpmtopdir)/SPECS/$(SPECFILE)
	$(rpmbuild) -ba $(SPECFILE)

srpm: dist $(SPECFILE)
	mkdir -p $(rpmtopdir)/{SOURCES,SPECS,BUILD,SRPMS,RPMS}
	cd dist && tar cvfz $(rpmtopdir)/SOURCES/$(PKGNAME)-$(PKGVERS).tgz $(PKGNAME)-$(PKGVERS)/*
	cp -f $(SPECFILE) $(rpmtopdir)/SPECS/$(SPECFILE)
	$(rpmbuild) -bs $(SPECFILE)

dist: $(SPECFILE)
	mkdir -p $(distdir)
	cp -f $(PROBES) $(distdir)/

clean:
	rm -rf dist
