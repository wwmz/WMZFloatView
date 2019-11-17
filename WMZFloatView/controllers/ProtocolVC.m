//
//  ProtocolVC.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "ProtocolVC.h"
#import "WMZFloatViewProtocol.h"
#import "UIImageView+WebCache.h"
@interface ProtocolVC ()<WMZFloatViewProtocol>

@end

@implementation ProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实现协议的控制器";
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169405&di=a69da15134c94f7fa7e0b2f92e2045d4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201508%2F08%2F20150808193353_xKTaQ.thumb.700_0.jpeg"]];
}

#pragma -mark WMZFloatViewProtocol
//可选实现
- (NSDictionary *)floatViewConfig{
    return @{@"name":@"实际显示在悬浮窗的标题",@"icon":@"float_image"};
}


@end
