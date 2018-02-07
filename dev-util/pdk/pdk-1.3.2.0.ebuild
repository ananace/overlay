# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils unpacker

DESCRIPTION="Puppet Development Kit"
HOMEPAGE="https://puppetlabs.com/"
SRC_BASE="http://apt.puppetlabs.com/pool/xenial/PC1/${PN:0:1}/${PN}/${PN}_${PV}-1xenial"
SRC_URI="
	amd64? ( ${SRC_BASE}_amd64.deb )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="strip mirror"

S=${WORKDIR}

QA_PREBUILT="
	/opt/puppetlabs/pdk
	/opt/puppetlabs/pdk/lib/engines/*
	/opt/puppetlabs/pdk/lib/*
	/opt/puppetlabs/pdk/bin/*"

src_install() {
	# Drop the opt folder into place
	insinto /opt
	doins -r opt/*

	# Add symlinks
	chmod 0755 -R "${D}/opt/puppetlabs/pdk/bin/"
    chmod 0755 -R "${D}/opt/puppetlabs/pdk/private/ruby/2.1.9/bin/"

	dosym ../../opt/puppetlabs/pdk/bin/pdk /usr/bin/pdk
}
