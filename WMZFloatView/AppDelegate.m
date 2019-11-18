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
    if (@available(ios 13, *)) {

      } else {
          UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[HomeVC alloc]init]];
          self.window.rootViewController = nav;
          //需要加这句话
          [self.window makeKeyAndVisible];
          
          
        //只带控制器的className
        [[WMZFloatManage shareInstance] registerControllers:@[@"ViewController"]];
        //带其他配置
        //   [[WMZFloatManage shareInstance] registerControllers:@[@{@"controllerName":@"ViewController",@"icon":@"float_circle_full"}]];
      }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
