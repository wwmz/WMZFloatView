



//
//  WMZFloatView.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZFloatView.h"
@interface WMZFloatView()
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UILabel *text;
@end
@implementation WMZFloatView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(FloatWidth/3*2., (FloatHeight-FloatWidth/3), FloatWidth/3, FloatWidth/3);
        [self addSubview:self.image];
        [self addSubview:self.text];
        self.image.frame = CGRectMake((FloatWidth/3-50)/2+10, (FloatWidth/3-50)/2, 50, 50);
        self.text.frame = CGRectMake(0, CGRectGetMaxY(self.image.frame), FloatWidth/3, 30);
        self.text.center = CGPointMake(self.image.center.x, self.text.center.y);
        self.text.textAlignment = NSTextAlignmentCenter;
        self.text.font = [UIFont systemFontOfSize:12.0f];

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(FloatWidth/3, FloatWidth/3) radius:FloatWidth/3 startAngle:2*M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(FloatWidth/3, FloatWidth/3)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        self.layer.mask = layer;
        self.layer.masksToBounds = YES;

    }
    return self;
}

- (void)setFull:(BOOL)full{
    _full = full;
    if (full) {
        [self fullCount];
    }else{
        [self notFullCount];
    }
}


//浮窗已满
- (void)fullCount{
    self.backgroundColor = FloatColor(0xeeeeee);
    self.text.textColor = FloatColor(0xc7c5c7);
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZFloatView class]] pathForResource:@"WMZFloatView" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:@"float_circle_full" ofType:@"png"];
    self.image.image = [UIImage imageWithContentsOfFile:path];
    self.text.text = @"浮窗已满";
}

//浮窗未满
-(void)notFullCount{
     self.backgroundColor = FloatColor(0x5a585a);
     self.text.textColor = [UIColor whiteColor];
     NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZFloatView class]] pathForResource:@"WMZFloatView" ofType:@"bundle"]];
     NSString *path = [bundle pathForResource:@"float_circle" ofType:@"png"];
     self.image.image = [UIImage imageWithContentsOfFile:path];
     self.text.text = @"浮窗";
}


- (UIImageView *)image{
    if (!_image) {
        _image = [UIImageView new];
    }
    return _image;
}

- (UILabel *)text{
    if (!_text) {
        _text = [UILabel new];
    }
    return _text;
}

@end
