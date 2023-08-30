# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jbruchon/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/jbruchon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A powerful duplicate file finder and an enhanced fork of 'fdupes'."
HOMEPAGE="https://github.com/jbruchon/jdupes"

IUSE="btrfs hardened"
LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"

src_compile() {
	emake \
		$(usex btrfs "ENABLE_BTRFS=1" "") \
		$(usex hardened "HARDEN=1" "")
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}"/usr
}
