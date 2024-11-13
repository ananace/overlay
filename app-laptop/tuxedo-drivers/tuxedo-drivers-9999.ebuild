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
		"clevo_acpi=tuxedo:${S}:src"
		"clevo_wmi=tuxedo:${S}:src"
		"tuxedo_keyboard=tuxedo:${S}:src"
		"uniwill_wmi=tuxedo:${S}:src"
		"ite_8291=tuxedo:${S}:src/ite_8291"
		"ite_8291_lb=tuxedo:${S}:src/ite_8291_lb"
		"ite_8297=tuxedo:${S}:src/ite_8297"
		"ite_829x=tuxedo:${S}:src/ite_829x"
		"tuxedo_compatibility_check=tuxedo:${S}:src/tuxedo_compatibility_check"
		"tuxedo_io=tuxedo:${S}:src/tuxedo_io"
		"tuxedo_nb02_nvidia_power_ctrl=tuxedo:${S}:src/tuxedo_nb02_nvidia_power_ctrl"
		"tuxedo_nb05_keyboard=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb05_kbd_backlight=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb05_power_profiles=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb05_ec=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb05_sensors=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb05_fan_control=tuxedo:${S}:src/tuxedo_nb05"
		"tuxedo_nb04_keyboard=tuxedo:${S}:src/tuxedo_nb04"
		"tuxedo_nb04_wmi_ab=tuxedo:${S}:src/tuxedo_nb04"
		"tuxedo_nb04_wmi_bs=tuxedo:${S}:src/tuxedo_nb04"
		"tuxedo_nb04_sensors=tuxedo:${S}:src/tuxedo_nb04"
		"tuxedo_nb04_power_profiles=tuxedo:${S}:src/tuxedo_nb04"
		"tuxedo_nb04_kbd_backlight=tuxedo:${S}:src/tuxedo_nb04"
		"tuxi_acpi=tuxedo:${S}:src/tuxedo_tuxi"
		"stk8321=tuxedo:${S}:src/stk8321"
		"gxtp7380=tuxedo:${S}:src/gxtp7380"
	)
	local modargs=( "KDIR=${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}
