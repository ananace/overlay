# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6..12} )

inherit distutils-r1

DESCRIPTION="Python package to talk to Brother QL label printers"
HOMEPAGE="https://github.com/pklaus/${PN} https://pypi.org/project/brother-ql"
SRC_URI="https://github.com/pklaus/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
RESTRICT="mirror"

DOCS="README.md"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/packbits[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
"

