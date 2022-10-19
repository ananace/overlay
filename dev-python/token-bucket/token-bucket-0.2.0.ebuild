# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6..10} )

inherit distutils-r1

DESCRIPTION="A Token Bucket Implementation for Python Web Apps"
HOMEPAGE="https://github.com/falconry/token-bucket https://pypi.python.org/pypi/token-bucket"
SRC_URI="https://github.com/falconry/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
RESTRICT="mirror"

DOCS="README.rst"

BDEPEND="
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	default
	sed -e "s/\['pytest-runner'\]/[]/" -i setup.py
}
