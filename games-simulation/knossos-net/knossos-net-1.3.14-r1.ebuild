# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="10.0"
NUGETS="
animatedimage.avalonia@1.0.7
avalonia@11.3.15
avalonia.angle.windows.natives@2.1.25547.20250602
avalonia.buildservices@11.3.2
avalonia.controls.colorpicker@11.3.15
avalonia.controls.datagrid@11.3.9
avalonia.desktop@11.3.15
avalonia.diagnostics@11.3.15
avalonia.freedesktop@11.3.15
avalonia.htmlrenderer@11.2.0
avalonia.markup.xaml.loader@11.3.15
avalonia.native@11.3.15
avalonia.remote.protocol@11.3.15
avalonia.skia@11.3.15
avalonia.themes.fluent@11.3.15
avalonia.themes.simple@11.3.15
avalonia.win32@11.3.15
avalonia.x11@11.3.15
communitytoolkit.mvvm@8.4.0
harfbuzzsharp@8.3.1.1
harfbuzzsharp.nativeassets.linux@8.3.1.1
harfbuzzsharp.nativeassets.macos@8.3.1.1
harfbuzzsharp.nativeassets.webassembly@8.3.1.1
harfbuzzsharp.nativeassets.win32@8.3.1.1
ini-parser-netstandard@2.5.2
microcom.runtime@0.11.0
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.dependencyinjection@8.0.1
microsoft.extensions.dependencyinjection.abstractions@8.0.2
microsoft.extensions.http@8.0.1
microsoft.extensions.logging@8.0.1
microsoft.extensions.logging.abstractions@8.0.2
microsoft.extensions.options@8.0.2
microsoft.extensions.primitives@8.0.0
observablecollections@3.3.3
sharpcompress@0.48.0
skiasharp@2.88.9
skiasharp.nativeassets.linux@2.88.9
skiasharp.nativeassets.macos@2.88.9
skiasharp.nativeassets.webassembly@2.88.9
skiasharp.nativeassets.win32@2.88.9
system.componentmodel.annotations@5.0.0
system.diagnostics.diagnosticsource@8.0.1
system.io.pipelines@8.0.0
system.runtime.compilerservices.unsafe@6.1.0
system.text.encodings.web@8.0.0
system.text.json@8.0.5
tmds.dbus.protocol@0.21.3
windowsshortcutfactory@1.2.0
"

inherit dotnet-pkg xdg-utils

DESCRIPTION="Knossos.NET, also known as KNet, is a multi-platform launcher for Freespace 2 Open"
HOMEPAGE="https://github.com/KnossosNET/Knossos.NET"

SRC_URI="https://github.com/KnossosNET/Knossos.NET/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/Knossos.NET-${PV}"

KEYWORDS="~amd64"

SRC_URI+=" ${NUGET_URIS} "

LICENSE="GPL-3.0"
SLOT="0"

DOTNET_PKG_PROJECTS=( "${S}/Knossos.NET/Knossos.NET.csproj" )

DOTNET_PKG_RESTORE_EXTRA_ARGS=(
	-p:RollForward=Major
)
DOTNET_PKG_BUILD_EXTRA_ARGS=( "${DOTNET_PKG_RESTORE_EXTRA_ARGS[@]}" )
DOTNET_PKG_TEST_EXTRA_ARGS=( "${DOTNET_PKG_RESTORE_EXTRA_ARGS[@]}" )

src_prepare() {
	dotnet-pkg_src_prepare

	# Based on ci/create_appimage.sh
	(
		source ./packaging/vars

		export _NAME="$NAME"
		export _ID="$ID"
		export _VERSION="$VERSION"

		envsubst < "packaging/linux/knossos.metainfo.xml.in" > "packaging/linux/${ID}.appdata.xml"
		envsubst < "packaging/linux/knossos.desktop.in" > "packaging/linux/${ID}.desktop"
	)
}

src_install() {
	dotnet-pkg_src_install

	dosym /usr/share/${P}/Knossos.NET /usr/bin/Knossos.NET

	insinto /usr/share/applications
	doins packaging/linux/io.github.knossosnet.Knossos_NET.desktop
	insinto /usr/share/metainfo
	doins packaging/linux/io.github.knossosnet.Knossos_NET.appdata.xml

	ICON_SIZES="512 256 128 96 64 48"
	for size in $ICON_SIZES; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "packaging/linux/knossos-${size}.png" io.github.knossosnet.Knossos_NET.png
	done
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
