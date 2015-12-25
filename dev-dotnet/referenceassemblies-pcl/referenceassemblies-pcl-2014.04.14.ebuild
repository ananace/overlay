EAPI=5

inherit versionator 

MY_PV=$(replace_all_version_separators '-')
MY_PN="PortableReferenceAssemblies"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Microsoft Portable Reference Libraries"
HOMEPAGE="Microsoft Portable Reference Libraries"
SRC_URI="http://storage.bos.xamarin.com/bot-provisioning/PortableReferenceAssemblies-${MY_PV}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/mono app-arch/unzip"
RESTRICT="mirror"

S="${WORKDIR}/${MY_P}"

src_install() {
	DIR="/usr/lib/mono/xbuild-frameworks/.NETPortable/"
	dodir $DIR
	cp -R v4.* ${D}/${DIR}
}
