SPECFILE = nagios-plugins-globus.spec
PROBES=src/GRAM-probe src/GridFTP-probe src/GridProxy-probe src/MyProxy-probe src/refresh_proxy src/CertLifetime-probe 

PKGNAME = $(shell grep -s '^Name:'    $(SPECFILE) | sed -e 's/Name: *//')
PKGVERS = $(shell grep -s '^Version:' $(SPECFILE) | sed -e 's/Version: *//')

distdir = dist/$(PKGNAME)-$(PKGVERS)

sources: dist $(SPECFILE)
	cd dist && tar cvfz ../$(PKGNAME)-$(PKGVERS).tgz $(PKGNAME)-$(PKGVERS)/*

dist: $(SPECFILE)
	mkdir -p $(distdir)
	cp -f $(PROBES) $(distdir)/

clean:
	rm -rf dist $(PKGNAME)-$(PKGVERS).tgz
