//
//  WMZFloatTool.h
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMZFloatTool : NSObject
//获取当前VC
+ (UIViewController *)getCurrentVC;
//圆心到点的距离>?半径
+ (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect;
//设置圆角 单边
+(void)setView:(UIView*)view Radii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner;
//设置圆角 单边 + 阴影
+(void)setView:(UIView*)view Radii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner shadom:(BOOL)shadom;
@end

@interface WMZFloatShapeView : UIView

@property(nonatomic,assign) CGSize radioSize;
@property(nonatomic,assign) UIRectCorner rectCorner;

@end

NS_ASSUME_NONNULL_END
