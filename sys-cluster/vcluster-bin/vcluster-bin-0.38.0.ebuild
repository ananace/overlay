# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit bash-completion-r1

MY_PN="${PN%-bin}"

DESCRIPTION="Create fully functional virtual Kubernetes clusters"
HOMEPAGE="https://www.vcluster.com/"
SRC_URI="
	amd64? ( https://github.com/loft-sh/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux-amd64 -> ${P}-amd64 )
	arm64? ( https://github.com/loft-sh/${MY_PN}/releases/download/v${PV}/${MY_PN}-linux-arm64 -> ${P}-arm64 )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

RESTRICT="mirror test"

QA_PREBUILT="
	usr/bin/${MY_PN}"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${MY_PN}"
	chmod +x "${S}/${MY_PN}"
}

src_install() {
	./${MY_PN} completion bash > ${MY_PN}.bash || die
	./${MY_PN} completion zsh > ${MY_PN}.zsh || die
	./${MY_PN} completion fish > ${MY_PN}.fish || die

	dobin ${MY_PN}

	newbashcomp ${MY_PN}.bash ${MY_PN}

	insinto /usr/share/zsh/site-functions
	newins ${MY_PN}.zsh _${MY_PN}

	insinto /usr/share/fish/vendor_completions.d
	doins ${MY_PN}.fish
}
