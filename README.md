# DingDongiOSHelper
叮咚买菜iOS插件

## 越狱用户
### 修改makefile文件内ip 与 port 生成插件安装到手机
 export THEOS_DEVICE_IP={your iphone ip} \
 export THEOS_DEVICE_PORT={your iphone port} \
 make \
 make package \
 make install 


## 非越狱用户
1. 获取脱壳app 
2. copy Tweak.x内容至[monkeydev](https://github.com/AloneMonkey/MonkeyDev)进行非越狱集成


## 如何使用
1. 提前进入下单页面，选定地址&派送时间&支付方式.
2. 开抢前10秒左右,点击立即支付，即可触发自动下单操作.

![res](https://user-images.githubusercontent.com/15953395/162850248-4609ac29-20ef-42b9-8060-b58f152bea4f.gif)
