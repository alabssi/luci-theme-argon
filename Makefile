# Copyright (C) 2008-2019 Jerrykuku
# Apache-2.0

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Argon Theme
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+wget +jsonfilter
PKG_VERSION:=2.4.3
PKG_RELEASE:=20250722

# اتركها فارغة لإطفاء تصغير CSS داخل بيئة البناء إن لزم
CONFIG_LUCI_CSSTIDY:=

# مهم: اجعل مرحلة التثبيت قبل تضمين luci.mk
define Package/luci-theme-argon/install
	# ملفات statics
	$(INSTALL_DIR) $(1)/www/luci-static/argon
	$(CP) -r ./htdocs/luci-static/argon/* $(1)/www/luci-static/argon/
	# احذف الخلفية الافتراضية
	rm -f $(1)/www/luci-static/argon/img/bg1.jpg

	# قوالب ucode / الثيم
	$(INSTALL_DIR) $(1)/usr/share/luci/themes
	$(CP) -r ./ucode/template/themes/argon/* $(1)/usr/share/luci/themes/ 2>/dev/null || true

	# سكربتات الإعدادات الافتراضية (إن وجدت)
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(CP) -r ./root/etc/uci-defaults/* $(1)/etc/uci-defaults/ 2>/dev/null || true
endef

include $(TOPDIR)/feeds/luci/luci.mk
# call BuildPackage - OpenWrt buildroot signature
