# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev

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

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}"

LICENSE="GPL-2+"
SLOT="0"

PATCHES=( )

pkg_setup() {
        local CONFIG_CHECK="
                ACPI_WMI
                IIO
                INPUT_SPARSEKMAP
                LEDS_CLASS_MULTICOLOR
        "

        local ERROR_LEDS_CLASS_MULTICOLOR="CONFIG_LEDS_CLASS_MULTICOLOR: is required for keyboard backlight"

        local ERROR_ACPI_WMI="CONFIG_ACPI_WMI: is required for tuxedo-drivers"
        local ERROR_INPUT_SPARSEKMAP="CONFIG_INPUT_SPARSEKMAP: is required for tuxedo-drivers"
        local ERROR_IIOP="CONFIG_IIO: is required for tuxedo-drivers"

        linux-mod-r1_pkg_setup
}


src_compile() {
	local modlist=(
		"clevo_acpi=tuxedo:${KV_OUT_DIR}:src"
		"clevo_wmi=tuxedo:${KV_OUT_DIR}:src"
		"tuxedo_keyboard=tuxedo:${KV_OUT_DIR}:src"
		"uniwill_wmi=tuxedo:${KV_OUT_DIR}:src"
		"ite_8291=tuxedo:${KV_OUT_DIR}:src/ite_8291"
		"ite_8291_lb=tuxedo:${KV_OUT_DIR}:src/ite_8291_lb"
		"ite_8297=tuxedo:${KV_OUT_DIR}:src/ite_8297"
		"ite_829x=tuxedo:${KV_OUT_DIR}:src/ite_829x"
		"tuxedo_compatibility_check=tuxedo:${KV_OUT_DIR}:src/tuxedo_compatibility_check"
		"tuxedo_io=tuxedo:${KV_OUT_DIR}:src/tuxedo_io"
		"tuxedo_nb02_nvidia_power_ctrl=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb02_nvidia_power_ctrl"
		"tuxedo_nb05_keyboard=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb05_kbd_backlight=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb05_power_profiles=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb05_ec=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb05_sensors=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb05_fan_control=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb05"
		"tuxedo_nb04_keyboard=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxedo_nb04_wmi_ab=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxedo_nb04_wmi_bs=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxedo_nb04_sensors=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxedo_nb04_power_profiles=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxedo_nb04_kbd_backlight=tuxedo:${KV_OUT_DIR}:src/tuxedo_nb04"
		"tuxi_acpi=tuxedo:${KV_OUT_DIR}:src/tuxedo_tuxi"
		"tuxedo_tuxi_fan_control=tuxedo:${KV_OUT_DIR}:src/tuxedo_tuxi"
		"stk8321=tuxedo:${KV_OUT_DIR}:src/stk8321"
		"gxtp7380=tuxedo:${KV_OUT_DIR}:src/gxtp7380"
	)
	local modargs=( "M=${S}" )

	linux-mod-r1_src_compile
}

src_install() {
        insinto /usr/lib/udev/hwdb.d
        doins *.hwdb
        udev_dorules *.rules
        linux-mod-r1_src_install
}

pkg_postinst() {
        linux-mod-r1_pkg_postinst
        systemd-hwdb update --root="${ROOT}"
        udev_reload
}

pkg_postrm() {
        udev_reload
}
