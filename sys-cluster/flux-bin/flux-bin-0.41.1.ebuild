# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit bash-completion-r1

MY_PN="${PN%-bin}"

DESCRIPTION="Open and extensible continuous delivery solution for Kubernetes"
HOMEPAGE="https://fluxcd.io"
SRC_URI="
	amd64? ( https://github.com/fluxcd/flux2/releases/download/v${PV}/flux_${PV}_linux_amd64.tar.gz )
	arm? ( https://github.com/fluxcd/flux2/releases/download/v${PV}/flux_${PV}_linux_arm.tar.gz )
	arm64? ( https://github.com/fluxcd/flux2/releases/download/v${PV}/flux_${PV}_linux_arm64.tar.gz )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE=""

RESTRICT="mirror test"

QA_PREBUILT="
	usr/bin/${MY_PN}"

S="${WORKDIR}"

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
