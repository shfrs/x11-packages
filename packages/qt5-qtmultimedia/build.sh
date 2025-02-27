TERMUX_PKG_HOMEPAGE=https://www.qt.io/
TERMUX_PKG_DESCRIPTION="Qt 5 Multimedia Library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION=5.12.11
TERMUX_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.12/${TERMUX_PKG_VERSION}/submodules/qtmultimedia-everywhere-src-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=918d253e9b5bca4f030e4207b2329d6a96c9901a5f52c5ed84725709aa54ee27
# qt5-qtdeclarative is not needed because quick widget requires OpenGL
TERMUX_PKG_DEPENDS="qt5-qtbase, pulseaudio, openal-soft, gstreamer, gst-plugins-base, gst-plugins-bad"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_configure () {
    "${TERMUX_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${TERMUX_PREFIX}/lib/qt/mkspecs/termux-cross" \
        GST_VERSION=1.0 \
        INCLUDEPATH+="${TERMUX_PREFIX}/include/gstreamer-1.0/" \
        INCLUDEPATH+="${TERMUX_PREFIX}/include/glib-2.0/" \
        INCLUDEPATH+="${TERMUX_PREFIX}/lib/glib-2.0/include"
}

termux_step_make_install() {
    make install

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
    find "${TERMUX_PREFIX}/lib" -type f -name "libQt5Multimedia*.prl" \
        -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

    ## Remove *.la files.
    find "${TERMUX_PREFIX}/lib" -iname \*.la -delete
}

