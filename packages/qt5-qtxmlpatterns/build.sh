TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt XmlPatterns Library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=5.12.11
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.12/${TERMUX_PKG_VERSION}/submodules/qtxmlpatterns-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=1df0583ff804ef3334da298218ac5641d46c99b1dc692ca5097d9fead4afd0bc
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtdeclarative"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_configure () {
    "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-cross"
}

termux_step_post_make_install() {
    ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
    find "${TERMUX_PREFIX}/lib" -type f -name "libQt5XmlPatterns*.prl" \
        -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

    ## Remove *.la files.
    find "${TERMUX_PREFIX}/lib" -iname \*.la -delete
}

