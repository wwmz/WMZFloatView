//
//  WMZFloatViewConfig.h
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#ifndef WMZFloatViewConfig_h
#define WMZFloatViewConfig_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WMZFloatTool.h"

#define  faloatWindow        [UIApplication sharedApplication].keyWindow

#define FloatColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  FloatWidth   [UIScreen mainScreen].bounds.size.width
#define  FloatHeight  [UIScreen mainScreen].bounds.size.height

#define  FloatShowColor FloatColor(0x1d76db)

#define  FloatIS_iPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size)  || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))
//状态栏高度
#define FloatStatusBarHeight (FloatIS_iPhoneX ? 44.f : 20.f)
//导航栏高度
#define FloatNavBarHeight (44.f+FloatStatusBarHeight)

#endif /* WMZFloatViewConfig_h */
