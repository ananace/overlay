# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm linux-mod-r1

DESCRIPTION="Driver for Motorcomm YT6801 Gigabit Ethernet controller"
HOMEPAGE="https://en.motor-comm.com/product/ethernet-control-chip"
SRC_URI="https://rpm.tuxedocomputers.com/fedora/43/x86_64/base/tuxedo-yt6801-$(ver_rs 3 '-').noarch.rpm"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

upstream_version=$(ver_cut 1-3)
aspm=1

src_prepare() {
	cat <<EOF > "${S}/usr/src/tuxedo-yt6801-${upstream_version}/Makefile"
yt6801-objs := fuxi-gmac-common.o fuxi-gmac-desc.o fuxi-gmac-ethtool.o fuxi-gmac-hw.o \
fuxi-gmac-net.o fuxi-gmac-pci.o fuxi-gmac-phy.o fuxi-efuse.o fuxi-gmac-ioctl.o
obj-m += yt6801.o

all:
	\$(MAKE) -C \$(KERNELDIR) M=\$(PWD) modules

clean:
	\$(MAKE) -C \$(KERNELDIR) M=\$(PWD) clean
EOF

	default
}

src_compile() {
	local modlist=(
		yt6801=kernel/drivers/net/ethernet/motorcomm:usr/src/tuxedo-yt6801-${upstream_version}
	)
	local modargs=(
		KERNELDIR="${KV_OUT_DIR}"
		KCFLAGS+="-DFXGMAC_INT_MODERATION_ENABLED=1 -DFXGMAC_PHY_SLEEP_ENABLE"
	)

	board_name="$(cat /sys/class/dmi/id/board_name)"

	# Disable ASPM on some devices
	if [ "GXxHRXx" == "$board_name" ] || [ "GM5IXxA" == "$board_name" ]; then
		aspm=0
	else
		# ASPM enabled
		modargs+=(
			KCFLAGS+="-DFXGMAC_ASPM_ENABLED -DFXGMAC_EPHY_LOOPBACK_DETECT_ENABLED"
		)
	fi

	linux-mod-r1_src_compile
}

src_install() {
	# Install the license file
	insinto /usr/share/licenses/${P}
	doins "${S}/usr/share/licenses/tuxedo-yt6801/LICENSE"

	# Install the documentation
	use doc && dodoc "${S}/usr/src/tuxedo-yt6801-${upstream_version}/Notice.txt"

	linux-mod-r1_src_install
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	if [ ${aspm} = 0 ]; then
		einfo "ASPM support has been disabled due to limitations on your machine"
	fi
}
