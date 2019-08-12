# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# MODULES_OPTIONAL_USE="module"
inherit linux-mod bash-completion-r1

DESCRIPTION="TUXEDO Computers Kernel module for keyboard backlighting"
HOMEPAGE="https://github.com/tuxedocomputers/tuxedo-keyboard"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tuxedocomputers/${PN}"
	KEYWORDS=""
else
	# SRC_URI="https://github.com/tuxedocomputers/${PN}/releases/download/v${PV}/${P}.tar.gz"
	# KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
	echo "No stable release yet."
	exit 1
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="" # dkms

DEPEND=""
RDEPEND="${DEPEND}"

MODULE_NAMES="tuxedo_keyboard(kernel/drivers/misc:.:src)"
BUILD_TARGETS="clean all"
CONFIG_CHECK=""

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -lt 3 10 0 && die "This version of ${PN} requires Linux >= 3.10"
}

src_compile() {
	# BUILD_PARAMS="KERNELDIR=${KERNEL_DIR}"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
