//
//  WMZFloatTool.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZFloatTool.h"

@implementation WMZFloatTool
//获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

//圆心到点的距离>?半径
+ (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect {
    CGFloat radius = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + radius, rect.origin.y + radius);
    double dx = fabs(point.x - center.x);
    double dy = fabs(point.y - center.y);
    double dis = hypot(dx, dy);
    return dis <= radius;
}

//设置圆角 单边 同时可设置阴影
+(void)setView:(UIView*)view Radii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner shadom:(BOOL)shadom {
    WMZFloatShapeView *shapeView = nil;
    if ([view viewWithTag:10086]) {
        shapeView = [view viewWithTag:10086];
    }else{
        shapeView = [[WMZFloatShapeView alloc] init];
        shapeView.tag = 10086;
        shapeView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        shapeView.layer.shadowRadius = 5.f;
        shapeView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
        shapeView.layer.shadowOpacity = 1.f;
        [view addSubview:shapeView];
        [view sendSubviewToBack:shapeView];
    }

    shapeView.radioSize = size;
    shapeView.rectCorner = rectCorner;
    if (rectCorner == (UIRectCornerBottomRight|UIRectCornerTopRight)) {
        shapeView.frame = CGRectMake(view.bounds.origin.x, view.bounds.origin.y, view.bounds.size.width-5, view.bounds.size.height);
    }else{
        shapeView.frame = CGRectMake(view.bounds.origin.x+5, view.bounds.origin.y, view.bounds.size.width-5, view.bounds.size.height);
    }
    [shapeView setNeedsLayout];

}

+(void)setView:(UIView*)view Radii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner {
    //设置只有一半圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}





@end

@implementation WMZFloatShapeView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    if (self.rectCorner == UIRectCornerAllCorners) {
         maskPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.height/2 startAngle:0 endAngle:2*M_PI clockwise:YES];;
    }else{
         maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.rectCorner cornerRadii:self.radioSize];
    }
    ((CAShapeLayer *)self.layer).path = maskPath.CGPath;
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
}

@end
