# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Head tracking software for MS Windows, Linux, and Apple OSX"
HOMEPAGE="https://github.com/opentrack/opentrack"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/opentrack/opentrack.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${P}.tar.gz"
	KEYWORDS="-* ~amd64 ~x86"
	RESTRICT="mirror"

	S="${WORKDIR}/${PN}-${P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="opencv wine"

DEPEND="
	opencv? (
		media-libs/opencv
	)
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/linguist-tools:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"

RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -e 's|wineg++|${CMAKE_COMMAND} -E env "PATH=/etc/eselect/wine/bin:$ENV{PATH}" -- wineg++|' -i proto-wine/CMakeLists.txt
	sed -e "s|share/doc/opentrack|share/doc/${P}|" -i cmake/opentrack-hier.cmake
	sed -e '/REMOVE_RECURSE/d' \
	    -e 's|"${CMAKE_INSTALL_PREFIX}/|"|' -i cmake/opentrack-i18n.cmake

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSDK_WINE=$(usex wine)
	)
	cmake_src_configure
}
