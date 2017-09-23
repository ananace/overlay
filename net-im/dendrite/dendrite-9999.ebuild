EAPI=6

inherit git-r3

DESCRIPTION="Dendron done right homeserver for Matrix"
HOMEPAGE="https://github.com/matrix-org/dendrite"
LICENSE="Apache-2.0"
EGIT_REPO_URI="https://github.com/matrix-org/dendrite.git"

SLOT="0"
KEYWORDS="~amd64"

DEPENDS="dev-go/gb"

src_compile() {
	gb build
}

src_install() {
	dodoc README.md INSTALL.md
	for b in bin/*-api-proxy bin/dendrite-* ; do
		dobin bin/${b}
	done

	insinto /etc/dendrite
	newins dendrite-config.yaml dendrite.yaml

	exeinto /usr/libexec/dendrite
	doexe bin/create-account bin/generate-keys
}
