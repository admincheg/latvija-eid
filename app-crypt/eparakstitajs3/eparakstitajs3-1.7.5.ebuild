# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Latvian eParkstitajs 3 application"
HOMEPAGE="https://www.eparaksts.lv"
SRC_URI="amd64? ( https://www.eparaksts.lv/download/287690814/225107e765281e0d6ca378dc53c5b155c0fceb762fb2dbf58d463f4d01b8d9f7/eparakstitajs3-1.7.5_amd64.tar.gz -> ${P}.tar.gz )"

RESTRICT="bindist mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:2
	app-crypt/latvia-eid
"
RDEPEND="${DEPEND}"
BDEPEND=""


src_unpack() {
	default

	mv "${WORKDIR}/eparakstitajs3" "${WORKDIR}/${P}" || die
}

src_install() {
	local MY_D="/opt/${PN}"

	exeinto "${MY_D}/bin"
	doexe bin/eparakstitajs3
	dosym "${MY_D}/bin/eparakstitajs3" "/usr/bin/eparakstitajs3"

	insinto "${MY_D}"
	doins -r lib/
}
