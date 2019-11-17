

//
//  normalVC.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "normalVC.h"
#import "UIImageView+WebCache.h"
@interface normalVC ()

@end

@implementation normalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"没有注册且没有实现协议的控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169421&di=d068572bc4115161e6f473bc507392f4&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn18%2F472%2Fw273h199%2F20180616%2F37c4-hcyszsa4891644.gif"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
