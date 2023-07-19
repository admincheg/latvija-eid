# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Latvian eParaksts token signing middleware"
HOMEPAGE="https://www.eparaksts.lv"
SRC_URI="amd64? ( https://www.eparaksts.lv/download/eparaksts-token-signing_237_amd64deb_2022-09-05_121820 -> ${P}.deb )"

RESTRICT="bindist mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:2
	sys-apps/pcsc-lite
	app-crypt/latvia-eid
	firefox? ( www-client/firefox )
	firefox-bin? ( www-client/firefox-bin )
	google-chrome? ( www-client/google-chrome )
	chromium? ( www-client/chromium )
"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="doc firefox firefox-bin google-chrome chromium"
REQUIRED_USE="^^ ( firefox firefox-bin google-chrome chromium )"

QA_PREBUILT="
	usr/lib/pkcs11/libeparaksts-module.so*
"

src_unpack() {
	mkdir "${S}" || die
	cd "${S}" || die
	unpack_deb "${DISTDIR}/${P}.deb"
}

src_prepare() {
	default

	rm -rf usr/local || die
	rm -f \
		usr/share/chromium/extensions/ecdpmdojhacnkledeihffppfimadpdcb.json \
		usr/share/chromium-browser/extensions/ecdpmdojhacnkledeihffppfimadpdcb.json \
		usr/share/google-chrome/extensions/ecdpmdojhacnkledeihffppfimadpdcb.json

	if use doc; then
		unpack "usr/share/doc/eparaksts-token-signing/changelog.gz" || die
		rm -f "usr/share/doc/eparaksts-token-signing/changelog.gz" || die
	fi

	mv "usr/lib/pkcs11/libeparaksts-module.so" "usr/lib/pkcs11/libeparaksts-module.so.${PV}"
	sed -i 's/\r//g' usr/share/applications/eparaksts-chrome-extension.desktop
}

src_install() {
	cp -a . "${ED}" || die "copy failed"

	rm -r "${ED}/usr/share/doc/eparaksts-token-signing" || die "Docs removing failed"

	if use doc ; then
		dodoc -r "usr/share/doc/eparaksts-token-signing"
	fi

	dosym "libeparaksts-module.so.${PV}" "/usr/lib/pkcs11/libeparaksts-module.so"
}
