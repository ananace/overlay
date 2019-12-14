# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=7

inherit font

DESCRIPTION="Microsoft's Tahoma font"
HOMEPAGE="http://microsoft.com"
SRC_URI=""
LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
FONTDIR="/usr/share/fonts/tahoma"
MYDISTDIR="/usr/portage/distfiles"

src_unpack() {

	ls ${MYDISTDIR}/tahoma.ttf >/dev/null || die "Get tahoma.ttf and tahomabd.ttf and put them in ${MYDISTDIR}"
	ls ${MYDISTDIR}/tahomabd.ttf >/dev/null || die "Get tahoma.ttf and tahomabd.ttf and put them in ${MYDISTDIR}"
	cp ${MYDISTDIR}/tahoma.ttf ${MYDISTDIR}/tahomabd.ttf ${S}

}
