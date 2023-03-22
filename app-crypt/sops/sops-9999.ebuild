# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mozilla/${PN}.git"
	KEYWORDS=""
	RESTRICT="network-sandbox"
else
	SRC_URI="
		https://github.com/mozilla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://ace-things.rgw.ctrl-c.liu.se/${P}-vendor.tar.xz
	"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
	RESTRICT="mirror"
fi

DESCRIPTION="Simple and flexible tool for managing secrets"
HOMEPAGE="https://github.com/mozilla/sops"

LICENSE="MPL-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.rst )

if [[ ${PV} == "9999" ]]; then
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
fi

src_compile() {
	CGO_ENABLED=0 \
	go build -v -ldflags "-s -w" -o "${PN}" ./cmd/sops
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin ${PN}
}
