# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE="+accessibility"

DEPEND="
	~x11-libs/qt-core-${PV}[debug=]
	~x11-libs/qt-gui-${PV}[accessibility=,debug=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/tools/uic
	src/widgets
	# FIXME: writes outside of the sandbox because of DESTDIR = $$QT.gui
	#src/plugins/accessible
)

src_configure() {
	local myconf=(
		$(qt_use accessibility)
	)
	qt5-build_src_configure
}