# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Libre Graph API C++/Qt Client"
HOMEPAGE="https://github.com/owncloud/libre-graph-api-cpp-qt-client"
SRC_URI="
	https://github.com/owncloud/libre-graph-api-cpp-qt-client/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/libre-graph-api-cpp-qt-client-${PV}/client"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT=""

RDEPEND="
	virtual/zlib:=
"
DEPEND="
	${RDEPEND}
	dev-qt/qtbase:6[network]
"
BDEPEND=""
