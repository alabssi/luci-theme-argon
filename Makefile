#
# Makefile for luci-theme-argon (custom)
# Copyright (C) 2008-2019 Jerrykuku
# License: Apache-2.0
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-theme-argon
LUCI_TITLE:=Argon Theme
LUCI_DEPENDS:=+wget +jsonfilter
PKG_VERSION:=2.4.3
PKG_RELEASE:=custom1

CONFIG_LUCI_CSSTIDY:=

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
endef

# install: copy theme files into package and remove bg1.jpg
define Package/$(PKG_NAME)/install
	# copy htdocs (css/js/img)
	$(INSTALL_DIR) $(1)/www/luci-static/argon
	$(CP) ./htdocs/luci-static/argon/* $(1)/www/luci-static/argon/ 2>/dev/null || true

	# copy ucode templates (if present)
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view/themes/argon
	$(CP) ./ucode/template/themes/argon/* $(1)/www/luci-static/resources/view/themes/argon/ 2>/dev/null || true

	# copy legacy lua view templates (if present)
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/argon
	$(CP) ./luasrc/view/themes/argon/* $(1)/usr/lib/lua/luci/view/themes/argon/ 2>/dev/null || true

	# copy root defaults (if present)
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(CP) ./root/etc/* $(1)/etc/uci-defaults/ 2>/dev/null || true

	# احذف الخلفية الافتراضية من الحزمة لتقليل الحجم
	rm -f $(1)/www/luci-static/argon/img/bg1.jpg || true
endef

# call BuildPackage - OpenWrt buildroot signature
$(eval $(call BuildPackage,$(PKG_NAME)))
