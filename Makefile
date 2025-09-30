# Copyright (C) 2008-2019 Jerrykuku
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Argon Theme
LUCI_DEPENDS:=+wget +jsonfilter
PKG_VERSION:=2.4.3
PKG_RELEASE:=20250930

CONFIG_LUCI_CSSTIDY:=

define Package/luci-theme-argon/install
	$(INSTALL_DIR) $(1)/www/luci-static/argon
	$(CP) ./htdocs/luci-static/argon/* $(1)/www/luci-static/argon/

	# نحذف الخلفية bg1.jpg من البكج نهائياً
	rm -f $(1)/www/luci-static/argon/img/bg1.jpg

	# ننسخ ملفات ucode/templates اذا موجودة
	$(INSTALL_DIR) $(1)/usr/share/luci/themes
	$(CP) ./ucode/template/themes/argon/* $(1)/usr/share/luci/themes/ 2>/dev/null || true

	# ننسخ ملفات الإعدادات الافتراضية
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./root/etc/uci-defaults/* $(1)/etc/uci-defaults/ 2>/dev/null || true
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
