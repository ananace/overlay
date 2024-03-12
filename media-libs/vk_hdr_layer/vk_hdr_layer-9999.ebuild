# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson multilib-minimal

DESCRIPTION="Vulkan layer utilizing a small color management / HDR protocol for experimentation"
HOMEPAGE="https://github.com/Zamundaaa/VK_hdr_layer"
EGIT_REPO_URI="https://github.com/Zamundaaa/VK_hdr_layer.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
IUSE="X"
REQUIRED_USE=""

BDEPEND="
	dev-build/ninja
	dev-util/vulkan-headers
"
DEPEND="
	dev-libs/wayland[${MULTILIB_USEDEP}]
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
"
RDEPEND="${DEPEND}"

multilib_src_configure() {
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}
