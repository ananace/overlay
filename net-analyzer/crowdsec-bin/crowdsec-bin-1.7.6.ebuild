# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

MY_PN="${PN%-bin}"

DESCRIPTION="CrowdSec - the open-source and participative security solution offering crowdsourced protection against malicious IPs and access to the most advanced real-world CTI. "
HOMEPAGE="https://github.com/crowdsecurity/crowdsec"
SRC_URI="
	amd64? ( https://github.com/crowdsecurity/crowdsec/releases/download/v${PV}/crowdsec-release.tgz -> crowdsec-release-${PV}.tgz )
"

IUSE="cron server"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND=""
SLOT="0"

QA_PREBUILT="
	usr/bin/crowdsec
	usr/bin/cscli
"

S="${WORKDIR}/crowdsec-v${PV}"

src_prepare() {
	default

	sed 's|/usr/local/bin|/usr/bin|' -i config/crowdsec.service
	sed 's|reload crowdsec|reload -q crowdsec|' -i config/crowdsec.cron.daily
}

src_install() {
	exeinto /usr/bin

	if use server; then
		doexe cmd/crowdsec/crowdsec
	fi
	doexe cmd/crowdsec-cli/cscli

	if use server; then
		insinto /etc/crowdsec/patterns
		doins config/patterns/*
	fi

	insinto /etc/crowdsec
	doins config/{config,console,context,detect,local_api_credentials,profiles,simulation}.yaml
	if use server; then
		keepdir /etc/crowdsec/acquis.d
		systemd_dounit config/crowdsec.service
	fi

	keepdir /etc/crowdsec/hub

	if use cron; then
		exeinto /etc/cron.daily
		doexe config/crowdsec.cron.daily
	fi
}
