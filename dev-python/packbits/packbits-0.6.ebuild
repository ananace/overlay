# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6..12} )

inherit distutils-r1

DESCRIPTION="PackBits encoder/decoder"
HOMEPAGE="https://github.com/psd-tools/packbits https://pypi.org/project/packbits"
SRC_URI="https://github.com/psd-tools/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
RESTRICT="mirror"

DOCS="README.rst"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
