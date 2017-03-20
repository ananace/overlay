# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

FRAMEWORKS_MINIMAL="5.30.0"
KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"

if [ ${PV} -eq 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/KDE/${PN}"
else
	SRC_URI="https://github.com/KDE/${PN}/archive/v${PV}.tar.gz"
fi

DESCRIPTION="KDE and Plasma resources management GUI"
HOMEPAGE="https://github.com/KDE/discover"
KEYWORDS=""
IUSE="+notifier flatpak packagekit snap"
RESTRICT="mirror"

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kattica)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtquickcontrols)
	$(add_qt_dep qtxml)
	packagekit? (
		app-admin/packagekit-qt
		dev-libs/appstream[qt5]
	)
	flatpak? (
		>=sys-apps/flatpak-0.6.12
		dev-libs/appstream[qt5]
	)
	notifier? (
		$(add_frameworks_dep kio)
		$(add_frameworks_dep knotifications)
	)
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kio-extras)
	>=dev-libs/kirigami-2.1.0:2
"

RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		-DWITH_NOTIFIER=$(usex notifier)
		-DBUILD_FlatpakBackend=$(usex flatpak)
		-DBUILD_SnapBackend=$(usex snap)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst
}
