# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit cmake-utils

REVISION="e23a7eef"
SRC_URI="https://github.com/RasPlex/OpenPHT/archive/v${PV}-${REVISION}.tar.gz"

DESCRIPTION="OpenPHT is a community driven fork of Plex Home Theater"
HOMEPAGE="https://github.com/RasPlex/OpenPHT"
RESTRICT="mirror"
SLOT="0"

RDEPEND="media-libs/sdl-image
	net-misc/shairplay
	media-libs/libmpeg2
	media-video/rtmpdump
	media-libs/libass
	app-pda/libplist
	x11-libs/libva
	x11-libs/libvdpau
	dev-libs/libcec"

S="${WORKDIR}/OpenPHT-${PV}-${REVISION}"

src_prepare() {
	epatch "${FILESDIR}/fribidi.patch"
}

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/opt/openpht"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dobin "${FILESDIR}/openpht"
	domenu "${FILESDIR}/openpht.desktop"
	newicon plex/Resources/plex-icon-256.png openpht.png
}
