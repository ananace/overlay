# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..12} )

inherit meson distutils-r1 multilib-minimal flag-o-matic

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more. AMDGPU testing branch"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	S="${WORKDIR}/MangoHud-${PV}"
	MY_SRC_URI="https://github.com/flightlessmango/MangoHud/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64 ~x86"
fi
SRC_URI="
	${MY_SRC_URI:-}
	https://github.com/ocornut/imgui/archive/v1.89.9.tar.gz -> imgui-1.89.9.tar.gz
	https://wrapdb.mesonbuild.com/v2/imgui_1.89.9-1/get_patch -> imgui_1.89.9-1_patch.zip
	https://github.com/epezent/implot/archive/refs/tags/v0.16.zip -> implot-0.16.zip
	https://wrapdb.mesonbuild.com/v2/implot_0.16-1/get_patch -> implot_0.16-1_patch.zip
	https://github.com/nlohmann/json/releases/download/v3.10.5/include.zip -> nlohmann_json-3.10.5.zip
	https://github.com/gabime/spdlog/archive/refs/tags/v1.14.1.tar.gz -> spdlog-1.14.1.tar.gz
	https://wrapdb.mesonbuild.com/v2/spdlog_1.14.1-1/get_patch -> spdlog_1.14.1-1_patch.zip
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.2.158.tar.gz -> vulkan-headers-1.2.158.tar.gz
	https://wrapdb.mesonbuild.com/v2/vulkan-headers_1.2.158-2/get_patch -> vulkan-headers-1.2.158-2-wrap.zip
"

LICENSE="MIT"
SLOT="0"
IUSE="+dbus glvnd +X xnvctrl wayland -video_cards_nvidia +video_cards_amdgpu"
REQUIRED_USE="
	xnvctrl? ( video_cards_nvidia )
"

BDEPEND="
	dev-python/mako[${PYTHON_USEDEP}]
	dev-build/ninja
"
DEPEND="
	!games-util/mangohud
	media-libs/glfw
	dev-util/glslang
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu]
	)
	glvnd? (
		media-libs/libglvnd[${MULTILIB_USEDEP}]
	)
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? (
		dev-libs/wayland[${MULTILIB_USEDEP}]
		x11-libs/libxkbcommon[wayland,${MULTILIB_USEDEP}]
	)
"

RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		unpack "${P}.tar.gz"
		A=("${A[@]/${P}.tar.gz}")
	fi

	cd "${S}/subprojects" || die
	default

	mkdir nlohmann_json-3.10.5
	mv {single_,}include LICENSE.MIT meson.build nlohmann_json-3.10.5/
}
multilib_src_configure() {
	local emesonargs=(
		"--force-fallback-for=imgui,implot,nlohmann_json,vulkan-headers"
		-Dappend_libdir_mangohud=false
		-Dinclude_doc=false
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	dodoc "${S}/data/MangoHud.conf"

	einstalldocs
}

pkg_postinst() {
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}
