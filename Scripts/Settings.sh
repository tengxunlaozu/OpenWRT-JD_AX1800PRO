#!/bin/bash

ESCAPE_SED() {
	printf '%s' "$1" | sed 's/[\\/&]/\\&/g'
}

WRT_THEME_ESCAPED=$(ESCAPE_SED "$WRT_THEME")
WRT_NAME_ESCAPED=$(ESCAPE_SED "$WRT_NAME")
WRT_IP_ESCAPED=$(ESCAPE_SED "$WRT_IP")
WRT_SSID_ESCAPED=$(ESCAPE_SED "$WRT_SSID")
WRT_WORD_ESCAPED=$(ESCAPE_SED "$WRT_WORD")

#移除luci-app-attendedsysupgrade
sed -i "/attendedsysupgrade/d" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认主题
sed -i "s/luci-theme-bootstrap/luci-theme-$WRT_THEME_ESCAPED/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改immortalwrt.lan关联IP
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP_ESCAPED/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#添加编译日期标识
sed -i "s/(\(luciversion || ''\))/(\1) + (' \/ $WRT_MARK-$WRT_DATE')/g" $(find ./feeds/luci/modules/luci-mod-status/ -type f -name "10_system.js")

WIFI_SH=$(find ./target/linux/qualcommax/base-files/etc/uci-defaults/ -type f -name "*set-wireless.sh" -print -quit 2>/dev/null)
if [ -n "$WIFI_SH" ]; then
	#修改WIFI名称
	sed -i "s/BASE_SSID='.*'/BASE_SSID='$WRT_SSID_ESCAPED'/g" "$WIFI_SH"
	#修改WIFI密码
	sed -i "s/BASE_WORD='.*'/BASE_WORD='$WRT_WORD_ESCAPED'/g" "$WIFI_SH"
fi

CFG_FILE="./package/base-files/files/bin/config_generate"
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$WRT_IP_ESCAPED/g" "$CFG_FILE"
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$WRT_NAME_ESCAPED'/g" "$CFG_FILE"

#配置文件修改
echo "CONFIG_PACKAGE_luci=y" >> ./.config
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> ./.config
echo "CONFIG_PACKAGE_luci-theme-$WRT_THEME=y" >> ./.config
echo "CONFIG_PACKAGE_luci-app-$WRT_THEME-config=y" >> ./.config

#手动调整的插件
if [ -n "$WRT_PACKAGE" ]; then
	echo -e "$WRT_PACKAGE" >> ./.config
fi

# JDCloud AX1800 Pro uses the IPQ6018 high-performance firmware set.
echo "CONFIG_FEED_nss_packages=n" >> ./.config
echo "CONFIG_FEED_sqm_scripts_nss=n" >> ./.config
echo "CONFIG_PACKAGE_luci-app-sqm=n" >> ./.config
echo "CONFIG_PACKAGE_sqm-scripts-nss=n" >> ./.config
echo "CONFIG_NSS_FIRMWARE_VERSION_11_4=n" >> ./.config
echo "CONFIG_NSS_FIRMWARE_VERSION_12_5=y" >> ./.config
echo "CONFIG_PACKAGE_kmod-usb-serial-qualcomm=y" >> ./.config
