# This file is part of MXE.
# See index.html for further information.

PKG             := astyle
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.05.1
$(PKG)_CHECKSUM := b2ccedbb49f7f892afd6a9a59a67b57c36c41df3
$(PKG)_SUBDIR   := astyle
$(PKG)_FILE     := astyle_$($(PKG)_VERSION)_linux.tar.gz
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/astyle/astyle/astyle%20$($(PKG)_VERSION)/$($(PKG)_FILE)

$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    cd '$(1)/build/gcc'
    $(MAKE) -C '$(1)/build/gcc' -j '$(JOBS)' \
	CXX='$(TARGET)-g++' \
        CBASEFLAGS='-W -Wall -fno-rtti -fno-exceptions -DASTYLE_NO_EXPORT' \
        release static
    $(MAKE) -C '$(1)/build/gcc' -j '$(JOBS)' \
        prefix='$(PREFIX)/$(TARGET)' \
        INSTALL=install \
        install
    install -m 644 '$(1)/src'/astyle*.h '$(PREFIX)/$(TARGET)/include'
    install -m 644 '$(1)/build/gcc/bin/libastyle.a' '$(PREFIX)/$(TARGET)/lib'
endef
