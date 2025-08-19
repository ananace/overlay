# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Additional Flatpak update timers - for user and non-default system installations"
HOMEPAGE="https://github.com/ananace/overlay"

SRC_URI=""
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""
RDEPEND="
	sys-apps/flatpak
	sys-apps/systemd
"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	systemd_newunit "${FILESDIR}/system-flatpak-update@.service" "flatpak-update@.service"
	systemd_newunit "${FILESDIR}/system-flatpak-update@.timer" "flatpak-update@.timer"

	systemd_newuserunit "${FILESDIR}/user-flatpak-update.service" "flatpak-update.service"
	systemd_newuserunit "${FILESDIR}/user-flatpak-update.timer" "flatpak-update.timer"
}
