# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools eutils systemd

DESCRIPTION="Xorg drivers for xrdp"
HOMEPAGE="http://www.xrdp.org/"
SRC_URI="https://github.com/neutrinolabs/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"
IUSE="glamor"

RDEPEND="
	>=net-misc/xrdp-0.9.14
	x11-libs/libX11:0=
	glamor? ( >=x11-base/xorg-server-1.19.0 x11-libs/libdrm )"
DEPEND="${RDEPEND}
	dev-lang/nasm:0="

PATCHES=(
	"${FILESDIR}"/${PN}-fix-glamor.patch
)

src_configure() {
	local myconf=(
		$(use_enable glamor)
	)

	autoreconf
	econf "${myconf[@]}"
}

src_install() {
	default
	prune_libtool_files --all
}

