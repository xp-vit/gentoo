# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Implementation of OMEMO (XEP-0384) in C"
HOMEPAGE="https://github.com/gkdr/libomemo"
SRC_URI="https://github.com/gkdr/libomemo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	dev-db/sqlite
	dev-libs/glib
	dev-libs/libgcrypt
	dev-libs/mxml
	"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	"

PATCHES=(
	"${FILESDIR}"/${P}-so-symlinks.patch
)

DOCS=( CHANGELOG.md README.md )

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install

	# Respect libdir other than /usr/lib, e.g. /usr/lib64
	local libdir="$(get_libdir)"
	if [[ ${libdir} != lib ]]; then
		mv "${D}"/usr/{lib,${libdir}} || die
	fi

	einstalldocs

	if ! use static-libs ; then
		rm "${D}/usr/${libdir}/libomemo.a" || die
	fi
}
