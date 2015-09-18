PKGNAME=nagios-plugins-globus
SPECFILE=${PKGNAME}.spec
FILES=src/GRAM-probe src/GridFTP-probe src/GridProxy-probe src/MyProxy-probe src/refresh_proxy src/CertLifetime-probe

PKGVERSION=$(shell grep -s '^Version:' $(SPECFILE) | sed -e 's/Version: *//')

dist:
	rm -rf dist
	mkdir -p dist/${PKGNAME}-${PKGVERSION}
	cp -pr ${FILES} dist/${PKGNAME}-${PKGVERSION}/.
	cd dist ; tar cfz ../${PKGNAME}-${PKGVERSION}.tar.gz ${PKGNAME}-${PKGVERSION}
	rm -rf dist

sources: dist

clean:
	rm -rf ${PKGNAME}-${PKGVERSION}.tar.gz
	rm -rf dist
