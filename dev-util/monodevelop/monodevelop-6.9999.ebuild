# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit fdo-mime gnome2-utils dotnet versionator eutils git-r3

DESCRIPTION="Integrated Development Environment for .NET"
HOMEPAGE="http://www.monodevelop.com/"

EGIT_REPO_URI="git://github.com/mono/monodevelop.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="mirror"

RDEPEND=">=dev-lang/mono-4.2
	>=dev-dotnet/gtk-sharp-2.12.21:2
	>=dev-dotnet/mono-addins-1.0[gtk]
	>=www-servers/xsp-2
	dev-dotnet/referenceassemblies-pcl
	dev-lang/fsharp
	dev-util/ctags
	sys-apps/dbus[X]
	doc? ( dev-util/mono-docbrowser )
	!<dev-util/monodevelop-boo-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-java-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-database-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-gdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-mdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-vala-$(get_version_component_range 1-2)"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-misc/shared-mime-info"
MAKEOPTS="${MAKEOPTS} -j1" #nowarn

src_prepare() {
	# Set specific_version to prevent binding problem
	# when gtk#-3 is installed alongside gtk#-2
	find "${S}" -name '*.csproj' -exec sed -i 's#<SpecificVersion>.*</SpecificVersion>#<SpecificVersion>True</SpecificVersion>#' {} + || die
}

src_configure() {
	if use test
		then tests="--enable-tests"
		else tests=""
	fi
	./configure \
		--prefix=/usr \
		--profile=stable \
		"${tests}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

