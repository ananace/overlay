# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit unpacker

MY_PN="${PN%-bin}"

DESCRIPTION="The Choria Orchestrator Server and Broker"
HOMEPAGE="https://choria.io"
SRC_URI="
	amd64? (
		https://apt.de.choria.io/release/debian/bullseye/pool/bullseye/c/choria/${MY_PN}_${PV}+bullseye_amd64.deb
		https://apt.uk.choria.io/release/debian/bullseye/pool/bullseye/c/choria/${MY_PN}_${PV}+bullseye_amd64.deb
		https://apt.us.choria.io/release/debian/bullseye/pool/bullseye/c/choria/${MY_PN}_${PV}+bullseye_amd64.deb
	)
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND=""
SLOT="0"

RESTRICT=""

QA_PREBUILT="
	usr/bin/choria"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	eapply_user

	gzip -d usr/share/doc/choria/changelog.gz
	mv usr/share/doc/choria usr/share/doc/${P}
	sed -e 's/syslog/journal/' -i 'lib/systemd/system/choria-server.service' 'lib/systemd/system/choria-broker.service'
}

src_install() {
	insinto /
	doins -r *

	fperms +x /usr/bin/${MY_PN}
}
