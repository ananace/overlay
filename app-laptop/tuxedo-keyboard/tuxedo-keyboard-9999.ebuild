# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod bash-completion-r1

DESCRIPTION="TUXEDO Computers Kernel module for keyboard backlighting"
HOMEPAGE="https://github.com/tuxedocomputers/tuxedo-keyboard"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tuxedocomputers/${PN}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tuxedocomputers/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

BUILD_TARGETS="all"
MODULE_NAMES="clevo_acpi(tuxedo:${S}:src) clevo_wmi(tuxedo:${S}:src) tuxedo_keyboard(tuxedo:${S}:src) tuxedo_io(tuxedo:${S}:src/tuxedo_io)"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="CC=$(tc-getBUILD_CC) KDIR=${KV_DIR} V=1 KBUILD_VERBOSE=1"
}

#src_prepare() {
#       eapply_user
#       #sed -i 's!KDIR := /lib/modules/$(shell uname -r)/build!KDIR := /lib/modules/'"${KV_FULL}"'/build!g' Makefile
#}
