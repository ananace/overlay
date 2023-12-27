# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CONFIG_CHECK="ACPI_WMI INPUT_SPARSEKMAP"

inherit linux-mod-r1

DESCRIPTION="Kernel Module for Tuxedo Keyboard"
HOMEPAGE="https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/tuxedocomputers/development/packages/${PN}"
	KEYWORDS=""
else
	SRC_URI="https://gitlab.com/tuxedocomputers/development/packages/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

PATCHES=( )

src_compile() {
	local modlist=(
		clevo_acpi=tuxedo:${S}:src
		clevo_wmi=tuxedo:${S}:src
		uniwill_wmi=tuxedo:${S}:src
		tuxedo_keyboard=tuxedo:${S}:src
		tuxedo_io=tuxedo:${S}:src/tuxedo_io
	)
	local modargs=( KDIR=${KV_OUT_DIR} )

	linux-mod-r1_src_compile
}
