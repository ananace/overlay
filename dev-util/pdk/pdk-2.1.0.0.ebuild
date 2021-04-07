# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils unpacker

DESCRIPTION="Puppet Development Kit"
HOMEPAGE="https://puppetlabs.com/"
SRC_BASE="http://apt.puppetlabs.com/pool/bionic/puppet-tools/${PN:0:1}/${PN}/${PN}_${PV}-1bionic"
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

src_prepare() {
	rm opt/puppetlabs/pdk/private/ruby/*/lib/ruby/gems/*/gems/ffi-*/ext/ffi_c/libffi-x86_64-linux/a.out
	rm opt/puppetlabs/pdk/share/cache/ruby/*/gems/ffi-*/ext/ffi_c/libffi-x86_64-linux/a.out

	# Remove broken libs to avoid QA errors
	rm opt/puppetlabs/pdk/private/ruby/*/lib/ruby/*/x86_64-linux/readline.so
}

src_install() {
	# Drop the opt folder into place
	insinto /opt
	doins -r opt/*

	# Ensure permissions
	find "${D}" -iwholename '*/bin/*' -exec chmod 0755 {} +
	chmod 0755 -R "${D}/opt/puppetlabs/pdk/private/git/lib/git-core/"

	# Add symlinks
	dosym /opt/puppetlabs/pdk/bin/pdk /usr/bin/pdk
}
