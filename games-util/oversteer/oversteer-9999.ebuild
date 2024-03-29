# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson udev

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/berarma/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/berarma/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="Steering Wheel Manager for Linux"
HOMEPAGE="https://github.com/berarma/oversteer"

LICENSE="GPL-3.0"
RESTRICT=""
SLOT="0"

DEPEND="
	dev-python/matplotlib
	dev-python/python-evdev
	dev-python/pygobject
	dev-python/python-distutils-extra
	dev-python/pyudev
	dev-python/scipy
	dev-python/pyxdg"

RDEPEND="${DEPEND}"

src_install() {
	meson_src_install

	udev_dorules data/udev/99-fanatec-wheel-perms.rules
	udev_dorules data/udev/99-logitech-wheel-perms.rules
	udev_dorules data/udev/99-thrustmaster-wheel-perms.rules
}
