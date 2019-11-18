Pod::Spec.new do |s|

  s.name         = "WMZFloatView"
  s.version      = "1.0.1"
  s.ios.deployment_target = "9.0" 
  s.license      = "Copyright (c) 2019年 WMZ. All rights reserved."
  s.summary      = "仿微信悬浮窗,可直接协议加入悬浮窗或者直接调用方法注册,可自定义转场动画"
  s.description  = <<-DESC 
                   仿微信悬浮窗,可直接协议加入悬浮窗或者直接调用方法注册,可自定义转场动画
                   注：Building Settings设置CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF为NO可以消除链  式编程的警告
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZFloatView"
  s.license      = "MIT"
  s.author       = { "wmz" => "925457662@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/wwmz/WMZFloatView.git", :tag => "1.0.1" }
  s.source_files = "WMZFloatView/WMZFloatView/**/*.{h,m}"
  s.framework = 'UIKit'
  s.resources     = "WMZFloatView/WMZFloatView/WMZFloatView.bundle"
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

end
