//
//  WMZFloatManage.h
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//


#import "WMZFloatView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZFloatManage : NSObject
//自定义push动画
@property(nonatomic,strong)NSObject<UIViewControllerAnimatedTransitioning> *pushAnimal;
//自定义pop动画
@property(nonatomic,strong)NSObject<UIViewControllerAnimatedTransitioning>  *popAnimal;
//单例
+ (instancetype) shareInstance;

//注册响应的controller
- (void)registerControllers:(NSArray*)controllers;

@end

NS_ASSUME_NONNULL_END
