include $(TOPDIR)/rules.mk

PKG_NAME:=luci-theme-argon
LUCI_TITLE:=Argon Theme
LUCI_DEPENDS:=+wget +jsonfilter
PKG_VERSION:=2.4.3
PKG_RELEASE:=custom2

CONFIG_LUCI_CSSTIDY:=

# تثبيت مخصص + حذف bg1.jpg
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/www/luci-static/argon
	$(CP) ./htdocs/luci-static/argon/* $(1)/www/luci-static/argon/ 2>/dev/null || true

	$(INSTALL_DIR) $(1)/www/luci-static/resources/view/themes/argon
	$(CP) ./ucode/template/themes/argon/* $(1)/www/luci-static/resources/view/themes/argon/ 2>/dev/null || true

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/themes/argon
	$(CP) ./luasrc/view/themes/argon/* $(1)/usr/lib/lua/luci/view/themes/argon/ 2>/dev/null || true

	# احذف الخلفية الافتراضية من الحزمة
	rm -f $(1)/www/luci-static/argon/img/bg1.jpg || true
endef

# سكربت ما بعد التثبيت لضمان اختفاءها على الجهاز حتى لو فلتت
define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || rm -f /www/luci-static/argon/img/bg1.jpg
exit 0
endef

include $(TOPDIR)/feeds/luci/luci.mk
