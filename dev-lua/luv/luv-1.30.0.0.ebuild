# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="libuv bindings for luajit and lua 5.1/5.2/5.3"
HOMEPAGE="https://github.com/luvit/${PN}"
MY_EXTRA_PV="${PV##*.}"
MY_PV="${PV%.*}-${MY_EXTRA_PV}"
SRC_URI="
         https://github.com/luvit/${PN}/releases/download/${MY_PV}/${PN}-${MY_PV}.tar.gz
         https://github.com/LuaJIT/LuaJIT/archive/v2.1.0-beta3.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc luajit shared shared_libuv"
RESTRICT="mirror"

RDEPEND="
	!luajit? ( >=dev-lang/lua-5.1:= )
	luajit? ( dev-lang/luajit:2= )"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	ln -s "${WORKDIR}/LuaJIT-2.1.0-beta3" deps/luajit
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_MODULE=no"
                "-DBUILD_SHARED_LIBS=$(usex shared)"
		"-DWITH_SHARED_LIBUV=$(usex shared_libuv)"
	)

	cmake-utils_src_configure
}
