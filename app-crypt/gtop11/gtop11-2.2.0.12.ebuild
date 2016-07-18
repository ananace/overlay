# Written for personal use, direct any issues to https://github.com/ace13/overlay

EAPI=5

inherit eutils

MY_PN="libgtop11dotnet"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="PKCS11 driver for the Gemalto Cryptocard token"
HOMEPAGE="http://www.gemalto.com"
SRC_URI="https://www.nemid.nu/dk-da/support/aktiver_nemid/aktiver_nemid_paa_hardware/installer_driver/drivers/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">dev-libs/boost-1.56.0
	sys-apps/pcsc-lite
	app-crypt/p11-kit
	dev-libs/opensc
	net-misc/openvpn
	app-crypt/ccid
	dev-libs/engine_pkcs11
	dev-libs/pkcs11-helper
"
DEPEND="${RDEPEND}"
RESTRICT="mirror"

S="${WORKDIR}/${MY_PN}-${PV}"
