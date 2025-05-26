# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev

DESCRIPTION="Linux device driver for Motorcomm YT6801 Gigabit Ethernet controllers"
HOMEPAGE="https://www.motor-comm.com/product/ethernet-control-chip"
SRC_URI="https://www.motor-comm.com/Public/Uploads/uploadfile/files/20250430/yt6801-linux-driver-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

PATCHES=( )
S="${WORKDIR}"

src_compile() {
	local modlist=(
		${PN}=src:src
	)
	local modargs=(
		KERNELDIR="${KV_OUT_DIR}"
	)

	linux-mod-r1_src_compile
}
