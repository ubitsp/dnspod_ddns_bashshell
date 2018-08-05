# dnspod_ddns_bashshell
该脚本兼容openwrt,依赖ca-bundle和curl这两个软件.
需要有公网ip,需要先在web页面随便添加一个a记录.
使用方法:
先到dnspod官网获取api token,位置为登陆后的 用户中心-安全设置-API Token,创建后获得id和token.
如果在路由器使用,并且路由器能获取到公网ip,请使用ddns_interface.sh
下载该脚本 wget https://raw.githubusercontent.com/ubitsp/dnspod_ddns_bashshell/master/ddns_interface.sh && chmod +x ddns_interface.sh
 运行该脚本格式为 ddns_interface.sh id token 主机名 域名 接口名.
例如你要更新的域名为test.example.com 接口名称可以使用ifconfig获得,有公网ip的那个接口名称就是,假设接口名字为pppoe-wan 那么就输入 ddns_interface.sh 12345 12345678910abcdef123456 test example.com pppoe-wan,该脚本会在30秒后运行,然后每隔30秒检查ip有没有变更.
如果是在路由器后的设备运行该脚本,请使用ddns.sh,格式同上.但是不需要接口名
例如 
ddns.sh 12345 12345678910abcdef123456 test example.com
