# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://codeberg.org/jbruchon/jdupes.git"
	inherit git-r3
else
	SRC_URI="https://codeberg.org/jbruchon/jdupes/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	src_unpack() {
		default

		mv jdupes jdupes-${PV}
	}
fi

DESCRIPTION="A powerful duplicate file finder and an enhanced fork of 'fdupes'."
HOMEPAGE="https://github.com/jbruchon/jdupes"

IUSE="hardened"
LICENSE="MIT"
RESTRICT=""
SLOT="0"

src_compile() {
	emake \
		$(usex hardened "HARDEN=1" "")
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}"/usr
}
