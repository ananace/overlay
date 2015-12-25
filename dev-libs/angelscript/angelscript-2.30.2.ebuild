# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/angelscript/angelscript-2.29.2.ebuild,v 1.1 2014/10/27 20:06:23 hasufell Exp $

EAPI=5

inherit toolchain-funcs multilib-minimal

DESCRIPTION="A flexible, cross-platform scripting library"
HOMEPAGE="http://www.angelcode.com/angelscript/"
SRC_URI="http://www.angelcode.com/angelscript/sdk/files/angelscript_${PV}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="app-arch/unzip"
RESTRICT="mirror"

S=${WORKDIR}/sdk
S2=${WORKDIR}/sdk_static

pkg_setup() {
	tc-export CXX AR RANLIB
}

src_prepare() {
	if use static-libs ; then
		cp -pR "${WORKDIR}"/sdk "${S2}"/ || die
	fi
	#epatch "${FILESDIR}"/${P}-execstack.patch
	multilib_copy_sources
}

multilib_src_compile() {
	einfo "Shared build"
	make -C ${PN}/projects/gnuc SHARED=1 VERSION=${PV} PREFIX=/usr

	if use static-libs ; then
		einfo "Static build"
		make -C ${PN}/projects/gnuc PREFIX=/usr
	fi
}

multilib_src_install() {
	doheader ${PN}/include/angelscript.h
	dolib.so ${PN}/lib/libangelscript_s.so
	dosym libangelscript_s.so /usr/$(get_libdir)/libangelscript.so

	if use static-libs ; then
		 dolib.a ${PN}/lib/libangelscript.a
	fi
}

multilib_src_install_all() {
	use doc && dohtml -r "${WORKDIR}"/sdk/docs/*
}
