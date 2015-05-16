# This file is part of MXE.
# See index.html for further information.

PKG             := potrace
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.12
$(PKG)_CHECKSUM := e66bd7d6ff74fe45a07d4046f6303dec5d23847f
$(PKG)_SUBDIR   := potrace-$($(PKG)_VERSION)
$(PKG)_FILE     := potrace-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://sourceforge.net/projects/potrace/files/' | \
    $(SED) -n 's,.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --with-libpotrace
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

$(PKG)_BUILD_SHARED =
