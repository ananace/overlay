# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Telegram binding for Qt"
HOMEPAGE="https://github.com/Kaffeine/telegram-qt"
LICENSE="LGPL-2.1+"
EGIT_REPO_URI="https://github.com/Kaffeine/telegram-qt.git"

SLOT="0"
KEYWORDS="~amd64"
IUSE="qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="
	qt4? ( dev-qt/qtcore:4 )
	qt5? ( dev-qt/qtcore:5 )
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}"
BUILD_DIR="${WORKDIR}/telegram-qt-build"
BUILD_DIR4="${BUILD_DIR}4"
BUILD_DIR5="${BUILD_DIR}5"

src_configure() {
	if use qt4 ;then
		BUILD_DIR="${BUILD_DIR4}"
		local mycmakeargs=(
			'-DUSE_QT4=true'
		)
		cmake-utils_src_configure
	fi
	if use qt5 ;then
		BUILD_DIR="${BUILD_DIR5}"
		local mycmakeargs=()
		cmake-utils_src_configure
	fi
}

src_compile() {
	if use qt4 ;then
		BUILD_DIR="${BUILD_DIR4}"
		cmake-utils_src_compile
	fi
	if use qt5 ;then
		BUILD_DIR="${BUILD_DIR5}"
		cmake-utils_src_compile
	fi
}

src_install() {
	if use qt4 ;then
		BUILD_DIR="${BUILD_DIR4}"
		cmake-utils_src_install
	fi
	if use qt5 ;then
		BUILD_DIR="${BUILD_DIR5}"
		cmake-utils_src_install
	fi
}
