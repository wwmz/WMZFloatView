//
//  ViewController.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//
#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //appdelegeta注册的控制器
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.message;
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.url]];
}

@end
