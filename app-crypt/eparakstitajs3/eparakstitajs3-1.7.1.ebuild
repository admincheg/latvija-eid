# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Latvian eParkstitajs 3 application"
HOMEPAGE="https://www.eparaksts.lv"
SRC_URI="amd64? ( https://www.eparaksts.lv/download/223518594/39da09a99bf0dee9aa129bf36ca376aa617832ad17482ec022ef03949d3ad4be/eparakstitajs3-1.7.1_amd64.tar.gz -> ${P}.tar.gz )"

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
