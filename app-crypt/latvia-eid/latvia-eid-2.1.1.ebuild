# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Latvian eID middleware"
HOMEPAGE="https://www.eparaksts.lv"
SRC_URI="amd64? ( https://www.pmlp.gov.lv/lv/media/9836/download?attachment -> ${P}.zip )"

RESTRICT="bindist mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/unzip
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="doc"

QA_PREBUILT="
	usr/lib/pkcs11/eidlv-pkcs11.so*
"

src_unpack() {
	unpack "${P}.zip"
	mkdir "${S}" || die
	cd "${S}" || die

	unpack_deb "${WORKDIR}/${PN}_${PV}-1_amd64.deb"
}

src_install() {
	cp -a . "${ED}" || die "copy failed"
	dodir opt/

	dosym "/opt/${PN}/lib/eidlv-pkcs11.so" "/usr/lib/pkcs11/eidlv-pkcs11.so"
}
