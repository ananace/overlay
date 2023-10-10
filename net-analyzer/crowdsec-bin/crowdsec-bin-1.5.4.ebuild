# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"

DESCRIPTION="CrowdSec - the open-source and participative security solution offering crowdsourced protection against malicious IPs and access to the most advanced real-world CTI. "
HOMEPAGE="https://github.com/crowdsecurity/crowdsec"
SRC_URI="
	amd64? ( https://github.com/crowdsecurity/crowdsec/releases/download/v${PV}/crowdsec-release.tgz -> crowdsec-release-${PV}.tgz )
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND=""
SLOT="0"

QA_PREBUILT="
	usr/bin/crowdsec
	usr/bin/cscli
"

S="${WORKDIR}"

src_install() {
	exeinto /usr/bin

	doexe crowdsec-v${PV}/cmd/crowdsec/crowdsec
	doexe crowdsec-v${PV}/cmd/crowdsec-cli/cscli
}
