#!/bin/sh

build_deb() {
    NAME=$1

    VERSION=`grep Version: ${NAME}/DEBIAN/control |cut -f 2 -d ' '`

    cd ${NAME}/usr/share/doc/${NAME}
    gzip -9 changelog
    cd - >/dev/null
    fakeroot dpkg-deb --build ${NAME} ${NAME}_${VERSION}_all.deb
    cd ${NAME}/usr/share/doc/${NAME}
    gzip -d changelog
    cd - >/dev/null
    lintian ${NAME}_${VERSION}_all.deb
}

build_deb localepurge-tiny
rm bachatalinux-builder/usr/share/bachatalinux-builder/localepurge-tiny*.deb
cp localepurge-tiny*.deb bachatalinux-builder/usr/share/bachatalinux-builder/
build_deb bachatalinux-builder

