# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic qmake-utils virtualx xdg

DESCRIPTION="The OpenCloud Desktop application"
HOMEPAGE="https://github.com/opencloud-eu/desktop"
SRC_URI="
	https://github.com/opencloud-eu/desktop/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/desktop-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE=""
RESTRICT=""

RDEPEND="
	virtual/zlib:=
	>=dev-db/sqlite-3.9.0
"
DEPEND="
	${RDEPEND}
	dev-qt/qtbase:6[concurrent,network,widgets,xml]
	dev-libs/qtkeychain
	dev-libs/kdsingleapplication
"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	dev-qt/qttools:6[linguist]
"

src_configure() {
	local mycmakeargs=(
		# Defaults, but ensure they're off
		-DWITH_APPIMAGEUPDATER=OFF
		-DWITH_AUTO_UPDATER=OFF

		# Broken upstream, testing always disabled
		#-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	TEST_VERBOSE=1 virtx cmake_src_test
}
