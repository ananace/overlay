# Copyright 2017 Alexander Olofsson
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 systemd

SRC_URI="https://github.com/matrix-org/synapse/archive/v${PV}.tar.gz"

IUSE="preview ldap metrics notifications"

DESCRIPTION="Reference Synapse Home Server"
HOMEPAGE="https://matrix.org"
RESTRICT="mirror"
SLOT="0"

RDEPEND=">=dev-python/twisted-16.0.0
	dev-python/bcrypt
	dev-python/lxml
	dev-python/msgpack
	dev-python/pillow
	dev-python/pyasn1
	dev-python/pynacl
	>=dev-python/pyopenssl-0.14
	dev-python/pyyaml
	dev-python/python-systemd
	dev-python/service_identity
	dev-python/ujson
	ldap? ( net-im/matrix-synapse-ldap3 )
	metrics? ( dev-python/psutil )
	preview? ( dev-python/netaddr )
	notifications? ( dev-python/jinja dev-python/bleach )"
DEPEND="${RDEPEND}
	dev-python/setuptool
	dev-python/setuptool_trial
	dev-python/mock"

src_install() {
	systemd_newunit "contrib/synapse.service" "matrix-synapse.service"
}

