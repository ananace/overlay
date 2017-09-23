EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/matrix-org"
GOLANG_PKG_BUILDPATH="/src/${GOLANG_PKG_IMPORTPATH}/${PN}"

inherit git-r3 golang-single

DESCRIPTION="Dendron done right homeserver for Matrix"
HOMEPAGE="https://github.com/matrix-org/dendrite"
LICENSE="Apache-2.0"
EGIT_REPO_URI="https://github.com/matrix-org/dendrite.git"

SLOT="0"
KEYWORDS="~amd64"


