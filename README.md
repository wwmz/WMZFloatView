# WMZFloatView 仿微信悬浮窗,可直接协议加入悬浮窗或者直接调用方法注册,可自定义转场动画

演示
==============
![floatShow.gif](https://upload-images.jianshu.io/upload_images/9163368-47e1e2172d9d09b8.gif?imageMogr2/auto-orient/strip)

用法1 在Appdelegate中注册  传入对应控制器的className
==============

     //只带控制器的className 
     [[WMZFloatManage shareInstance] registerControllers:@[@"ViewController"]];
      //带其他配置(标题和图片)
    [[WMZFloatManage shareInstance]    registerControllers:@[@{@"controllerName":@"ViewController",@"icon":@"float_circle_full"}]];

用法2 实现协议 WMZFloatViewProtocol 即可
==============

     //可选实现协议的方法 传入标题和图片
      - (NSDictionary *)floatViewConfig{
        return @{@"name":@"实际显示在悬浮窗的标题",@"icon":@"float_image"};
     }

用法3 改变转场动画 传入继承UIViewControllerAnimatedTransitioning协议的类即可
==============
    //自定义push动画
    @property(nonatomic,strong)NSObject<UIViewControllerAnimatedTransitioning> *pushAnimal;
    //自定义pop动画
    @property(nonatomic,strong)NSObject<UIViewControllerAnimatedTransitioning>  *popAnimal;

### 依赖
无任何依赖 

安装
==============

### CocoaPods
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'WMZFloatView'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "WMZFloatManage.h"。

### 注:要消除链式编程的警告 
要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO

### 手动安装

1. 下载 WMZFloatView 文件夹内的所有内容。
2. 将 WMZFloatView 内的源文件添加(拖放)到你的工程。
3. 导入 #import "WMZFloatManage.h"

系统要求
==============
该库最低支持 `iOS 9.0` 和 `Xcode 9.0`。


许可证
==============
LEETheme 使用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。


个人主页
==============
使用过程中如果有什么bug欢迎给我提issue 我看到就会解决
[我的简书](https://www.jianshu.com/p/32e997b74d74)

