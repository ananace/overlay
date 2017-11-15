# Copyright 2017 Alexander Olofsson
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils gnome2-utils unpacker

MY_PN=${PN/-bin/}

DESCRIPTION="A glossy Matrix collaboration client for the web."
HOMEPAGE="https://riot.im"
SRC_URI="
	amd64? ( https://riot.im/packages/debian/pool/main/r/${MY_PN}/${MY_PN}_${PV}_amd64.deb )
	x86? ( https://riot.im/packages/debian/pool/main/r/${MY_PN}/${MY_PN}_${PV}_i386.deb )"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
RDEPEND=""
SLOT="0"

RDEPEND="
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango"

RESTRICT="mirror"

QA_PREBUILT="
	opt/Riot/libffmpeg.so
	opt/Riot/libnode.so
	opt/Riot/riot-web"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	default

	sed -i -e "s:\"/opt/Riot/riot-web\":riot-web:g" \
		usr/share/applications/${MY_PN}.desktop || die
}

src_install() {
	insinto /
	doins -r *

	fperms +x /opt/Riot/${MY_PN}
	dosym /opt/Riot/${MY_PN} /usr/bin/${MY_PN}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
