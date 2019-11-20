//
//  AppDelegate.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeVC.h"
#import "WMZFloatManage.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[HomeVC alloc]init]];
    self.window.rootViewController = nav;
    //需要加这句话
    [self.window makeKeyAndVisible];
             
             
    //只带控制器的className
    [[WMZFloatManage shareInstance] registerControllers:@[@"ViewController"]];
    //带其他配置
    //   [[WMZFloatManage shareInstance] registerControllers:@[@{@"controllerName":@"ViewController",@"icon":@"float_circle_full"}]];
    return YES;
}



@end
