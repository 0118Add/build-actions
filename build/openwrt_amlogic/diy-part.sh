#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# DIY扩展二合一了，在此处可以增加插件
# 自行拉取插件之前请SSH连接进入固件配置里面确认过没有你要的插件再单独拉取你需要的插件
# 不要一下就拉取别人一个插件包N多插件的，多了没用，增加编译错误，自己需要的才好
# 修改IP项的EOF于EOF之间请不要插入其他扩展代码，可以删除或注释里面原本的代码



#cat >$NETIP <<-EOF
#uci set network.lan.ipaddr='192.168.2.10'                      # IPv4 地址(openwrt后台地址)
#uci set network.lan.netmask='255.255.255.0'                   # IPv4 子网掩码
#uci set network.lan.gateway='192.168.2.1'                    # 旁路由设置 IPv4 网关（去掉uci前面的#生效）
#uci set network.lan.broadcast='192.168.2.255'                # 旁路由设置 IPv4 广播（去掉uci前面的#生效）
#uci set network.lan.dns='223.5.5.5 114.114.114.114'          # 旁路由设置 DNS(多个DNS要用空格分开)（去掉uci前面的#生效）
#uci set network.lan.delegate='0'                              # 去掉LAN口使用内置的 IPv6 管理(若用IPV6请把'0'改'1')
#uci set dhcp.@dnsmasq[0].filter_aaaa='1'                      # 禁止解析 IPv6 DNS记录(若用IPV6请把'1'改'0')

#uci set dhcp.lan.ignore='1'                                  # 旁路由关闭DHCP功能（去掉uci前面的#生效）
#uci delete network.lan.type                                  # 旁路由去掉桥接模式（去掉uci前面的#生效）
#uci set system.@system[0].hostname='OpenWrt-123'              # 修改主机名称为OpenWrt-123
#uci set ttyd.@ttyd[0].command='/bin/login -f root'           # 设置ttyd免帐号登录（去掉uci前面的#生效）

# 如果有用IPV6的话,可以使用以下命令创建IPV6客户端(LAN口)（去掉全部代码uci前面#号生效）
#uci set network.ipv6=interface
#uci set network.ipv6.proto='dhcpv6'
#uci set network.ipv6.ifname='@lan'
#uci set network.ipv6.reqaddress='try'
#uci set network.ipv6.reqprefix='auto'
#uci set firewall.@zone[0].network='lan ipv6'
#EOF

echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
git clone https://github.com/gd0772/package package/gd772
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
wget https://raw.githubusercontent.com/0118Add/patch/main/n1.sh
bash n1.sh

# TIME y "删除添加插件"
#rm -rf feeds/luci/collections/luci-lib-docker
#rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/applications/luci-app-netdata
#git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-netdata package/luci-app-netdata

#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/passwall
#git clone https://github.com/xiaorouji/openwrt-passwall2.git package/openwrt-passwall2
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#rm -rf feeds/luci/themes/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic

# TIME y "替换index.htm文件"
#wget -O ./package/lean/autocore/files/arm/index.htm https://raw.githubusercontent.com/0118Add/Actions-Shangyou/main/n1_index.htm

# 把bootstrap替换成argon为源码必选主题（可自行修改您要的,主题名称必须对,比如下面代码的[argon],源码内必须有该主题,要不然编译失败）
#sed -i "s/bootstrap/argon/ig" feeds/luci/collections/luci/Makefile


# 编译多主题时,设置固件默认主题（可自行修改您要的,主题名称必须对,比如下面代码的[argon],和肯定编译了该主题,要不然进不了后台）
#sed -i "/exit 0/i\uci set luci.main.mediaurlbase='/luci-static/argon' && uci commit luci" "$FIN_PATH"


# 增加个性名字 ${Author} 默认为你的github帐号,修改时候把 ${Author} 替换成你要的
#sed -i "s/OpenWrt /${Author} compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" "$ZZZ_PATH"


# 设置首次登录后台密码为空（进入openwrt后自行修改密码）
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' "$ZZZ_PATH"


# TIME y "删除默认防火墙"
#sed -i '/to-ports 53/d' "$ZZZ_PATH"
#echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

# 取消路由器每天跑分任务
#sed -i "/exit 0/i\sed -i '/coremark/d' /etc/crontabs/root" "$FIN_PATH"


# 设置打包固件的机型，内核组合（可用内核是时时变化的,过老的内核就删除的，所以要选择什么内核请看说明）
# 当前可用机型 s922x s922x-n2 s922x-reva a311d s905x3 s905x2 s905x2-km3 s905l3a s912 s912-m8s s905d s905d-ki s905x s905w s905

cat >"$AMLOGIC_SH_PATH" <<-EOF
amlogic_model=s905x3_s905d
amlogic_kernel=5.18.3_5.15.50 -a true
rootfs_size=960
EOF


# TIME y "修改插件名字"
#sed -i 's/"aMule设置"/"电驴下载"/g' `egrep "aMule设置" -rl ./`
#sed -i 's/"网络存储"/"NAS"/g' `egrep "网络存储" -rl ./`
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `egrep "Turbo ACC 网络加速" -rl ./`
#sed -i 's/"实时流量监测"/"流量"/g' `egrep "实时流量监测" -rl ./`
#sed -i 's/"KMS 服务器"/"KMS激活"/g' `egrep "KMS 服务器" -rl ./`
#sed -i 's/"TTYD 终端"/"命令窗"/g' `egrep "TTYD 终端" -rl ./`
#sed -i 's/"USB 打印服务器"/"打印服务"/g' `egrep "USB 打印服务器" -rl ./`
#sed -i 's/"Web 管理"/"Web管理"/g' `egrep "Web 管理" -rl ./`
#sed -i 's/"管理权"/"改密码"/g' `egrep "管理权" -rl ./`
#sed -i 's/"带宽监控"/"监控"/g' `egrep "带宽监控" -rl ./`
#sed -i 's/"解除网易云音乐播放限制"/"音乐解锁"/g' `egrep "解除网易云音乐播放限制" -rl ./`
#sed -i 's/"Docker CE 容器"/"Docker 容器"/g' `egrep "Docker CE 容器" -rl ./`
#sed -i 's/Docker CE 容器/Docker 容器/g' feeds/luci/applications/luci-app-docker/po/zh-cn/docker.po

# TIME y "调整 Dockerman 到 服务 菜单"
#sed -i 's/docker/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/controller/*.lua
#sed -i 's/docker/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/*.lua
#sed -i 's/docker/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
#sed -i 's/docker/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
#sed -i 's/docker/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# TIME y "调整 Zerotier 到 服务 菜单"
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/controller/*.lua
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/*.htm

# TIME y "调整 bypass 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/view/bypass/*.htm

# TIME y "调整 SSRP 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# TIME y "调整 Pass Wall 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm

# TIME y "调整 Hello World 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# TIME y "调整 Open Clash 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/view/openclash/*.htm

# 整理固件包时候,删除您不想要的固件或者文件,让它不需要上传到Actions空间
cat >"$CLEAR_PATH" <<-EOF
packages
config.buildinfo
feeds.buildinfo
default.manifest
sha256sums
Image
Image-initramfs
version.buildinfo
default.manifest
EOF

# TIME g "自定义文件修复权限"
#chmod -R 755 package

#./scripts/feeds update -i
#./scripts/feeds install -a
