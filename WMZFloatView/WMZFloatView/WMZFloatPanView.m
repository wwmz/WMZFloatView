
//
//  WMZFloatPanView.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/12.
//  Copyright © 2019 wmz. All rights reserved.
//
#define panSize 70
#import "WMZFloatPanView.h"
@interface WMZFloatPanView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)CGFloat cellHeight;
@end
@implementation WMZFloatPanView


- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(FloatWidth-panSize, FloatHeight/3, panSize, panSize);

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        self.userInteractionEnabled = YES;;
        [self addGestureRecognizer:pan];
        
        self.alpha = 0.8;
        [WMZFloatTool setView:self Radii:CGSizeMake(panSize/2, panSize/2) RoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft shadom:YES];

    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer*)pan{
    CGPoint tpoint = [pan translationInView:self];
    CGPoint center =  self.center;
    center.x += tpoint.x;
    center.y += tpoint.y;
    self.center = center;
    [pan setTranslation:CGPointZero inView:self];
    CGRect rect = self.frame;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [WMZFloatTool setView:self Radii:CGSizeMake(panSize/2, panSize/2) RoundingCorners:UIRectCornerAllCorners shadom:YES];
            for (UIImageView *view in self.subviews) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    CGRect rect = view.frame;
                    rect.origin.x += 7;
                    view.frame = rect;
                }
            }
        }
            break;

        case UIGestureRecognizerStateEnded:
        {

            if (rect.origin.y < FloatStatusBarHeight) {
                rect.origin.y = FloatStatusBarHeight;
            }else if (rect.origin.y> (FloatIS_iPhoneX?(FloatHeight-rect.size.height-panSize/2):(FloatHeight-rect.size.height))){
                rect.origin.y = FloatIS_iPhoneX?(FloatHeight-rect.size.height-panSize/2):(FloatHeight-rect.size.height);
            }
            
            if (self.frame.origin.x>=FloatWidth/2) {
                rect.origin.x = FloatWidth - rect.size.width;
            }else if (self.frame.origin.x<FloatWidth/2){
                rect.origin.x = 0;
            }
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = rect;
        if (pan.state == UIGestureRecognizerStateEnded) {
            if (self.frame.origin.x>=FloatWidth/2) {
                [WMZFloatTool setView:self Radii:CGSizeMake(panSize/2, panSize/2) RoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft shadom:YES];
                for (UIImageView *view in self.subviews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        CGRect rect = view.frame;
                        rect.origin.x -= 7;
                        view.frame = rect;
                    }
                }
            }else if (self.frame.origin.x<FloatWidth/2){
                [WMZFloatTool setView:self Radii:CGSizeMake(panSize/2, panSize/2) RoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight shadom:YES];
                for (UIImageView *view in self.subviews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        CGRect rect = view.frame;
                        rect.origin.x -= 7;
                        view.frame = rect;
                    }
                }
            }
            
        }
    }];
}

//更新圆形图案 最大5个图案
- (void)updateBall:(NSCache*)cache withKeyArr:(NSArray*)keyArr{
    NSInteger normalCount = 0;
    for (UIImageView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
            normalCount+=1;
        }
    }
    //显示的图案数组
    NSMutableArray *data = [NSMutableArray new];
    for (NSString *key in keyArr) {
        NSDictionary *dic = [cache objectForKey:key];
        if (![dic objectForKey:@"hide"]||![[dic objectForKey:@"hide"] boolValue]) {
            [data addObject:key];
        }
    }

   NSDictionary *scaleDic = @{
        @(1):@(1.0),
        @(2):@(0.5),
        @(3):@(0.38),
        @(4):@(0.35),
        @(5):@(0.30),
    };
    CGFloat scale = 0.7;
    scale *= [scaleDic[@(data.count)] floatValue];
    CGFloat height = scale*panSize;
    CGFloat width = scale*panSize;
    
    NSDictionary *dic = @{
        @(1):@[
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize*0.15, panSize*0.15, width, height)],
                    @"cornerRadius":@(height/2)
                }
        ],
        @(2):@[
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize*scale-panSize/6, panSize*scale , width, height)],
                    @"pathAngle":@(M_PI_4)
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize*scale-panSize/6+panSize*scale-4, panSize*scale , width, height)],
                    @"cornerRadius":@(height/2)
                }
        ],
        @(3):@[
              @{
                @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale/2, panSize*scale, width, height)],
                @"pathAngle":@(M_PI_4),
                @"toValue":@(M_PI_2+M_PI_4)
              },
              @{
                @"frame":[NSValue valueWithCGRect:CGRectMake(panSize*scale,panSize*scale  + height -4, width, height)],
                @"pathAngle":@(M_PI_4),
                @"toValue":@(M_PI*2),
                @"fromValue":@(M_PI)
              },
              @{
                @"frame":[NSValue valueWithCGRect:CGRectMake(panSize*scale +width  -2, panSize*scale + height -4, width, height)],
                @"pathAngle":@(M_PI_4),
                @"toValue":@(-M_PI_2-M_PI_4)
                },
        ],
        @(4):@[
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale/2, panSize*scale , width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(M_PI_2+M_PI_4)
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale,panSize*scale + height-5, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(M_PI_4),
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale + width +2, panSize*scale + height-7, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(-M_PI_2-M_PI_4)
                    },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale/2+2, panSize*scale  + height*2 -7-5, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(-M_PI_4)
                },
        ],
        @(5):@[

                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale/2, panSize*scale, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(M_PI_2+M_PI_4),
                    @"controlPoint":[NSValue valueWithCGPoint:CGPointMake(width/3, height/3)]
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale/2-panSize*scale/2,panSize*scale + height -5, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(M_PI_4+M_PI_4/2),
                    @"controlPoint":[NSValue valueWithCGPoint:CGPointMake(width/3, height/3)]
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2 +3 ,panSize*scale + height -5 -2, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(-M_PI_2-M_PI_4),
                    @"controlPoint":[NSValue valueWithCGPoint:CGPointMake(width/3, height/3)]
                    },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale+3, panSize*scale + height*2 -5 -2 -1, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(2*M_PI),
                    @"fromValue":@(M_PI),
                    @"controlPoint":[NSValue valueWithCGPoint:CGPointMake(width/3, height/3)]
                },
                @{
                    @"frame":[NSValue valueWithCGRect:CGRectMake(panSize/2-panSize*scale+3 + width -2,  panSize*scale + height*2 -5 -2 -1-1, width, height)],
                    @"pathAngle":@(M_PI_4),
                    @"toValue":@(-M_PI_2/3-M_PI_4),
                    @"controlPoint":[NSValue valueWithCGPoint:CGPointMake(width/3, height/3)]
                },
        ],
    };
    
    NSArray *config = dic[@(data.count)];
    
    NSMutableArray *imageArr = [NSMutableArray new];
    for (NSString *key in data) {
        UIImageView *image = [UIImageView new];
        NSDictionary *detailDic = [cache objectForKey:key];
        if (detailDic[@"icon"]) {
            image.image = [UIImage imageNamed:detailDic[@"icon"]];
        }else{
            image.backgroundColor = FloatShowColor;
        }
        image.layer.masksToBounds = YES;
        [imageArr addObject:image];
        [self addSubview:image];
        [self bringSubviewToFront:image];
    }
    
    CFTimeInterval time = ((data.count == normalCount)?0.01:1);
    
    for (int i = 0; i<imageArr.count; i++) {
        UIImageView *image = imageArr[i];
        NSDictionary *frameDic = config[i];
        image.frame = [frameDic[@"frame"] CGRectValue];
        if (frameDic[@"cornerRadius"]) {
            image.layer.cornerRadius = [frameDic[@"cornerRadius"] floatValue];
        }
        if (frameDic[@"pathAngle"]) {
            CGPoint point = [frameDic[@"controlPoint"] CGPointValue];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = [self getPathWithRadius:image.frame.size.height/2 center:CGPointMake(image.frame.size.width/2, image.frame.size.height/2) angle:[frameDic[@"pathAngle"] doubleValue] controlPoint:point].CGPath;
            layer.frame = image.bounds;
            if (frameDic[@"toValue"]) {
                double toValue = [frameDic[@"toValue"] doubleValue];
                double fromValue =  [frameDic[@"fromValue"] doubleValue];
                [layer addAnimation:[self getAnimationWithValue:toValue fromValue:fromValue duration:time] forKey:nil];
            }
            image.layer.mask = layer;
            
        }
    }
}

//获取扇形
- (UIBezierPath*)getPathWithRadius:(CGFloat)radio center:(CGPoint)centerPoint angle:(double)angle controlPoint:(CGPoint)controlPoint{
    if (controlPoint.x == 0&&controlPoint.y == 0) {
        controlPoint = centerPoint;
    }
    UIBezierPath *otherPath = [UIBezierPath bezierPath];
    CGFloat line = cos(angle)*radio;
    [otherPath moveToPoint:CGPointMake(centerPoint.x+line,centerPoint.y-line)];
    [otherPath addQuadCurveToPoint:CGPointMake(centerPoint.x+line, line+centerPoint.y) controlPoint:CGPointMake(controlPoint.x, centerPoint.y)];
    [otherPath addArcWithCenter:centerPoint radius:radio startAngle:angle endAngle:2*M_PI- angle clockwise:YES];

    return otherPath;
    
}

//动画
- (CABasicAnimation*)getAnimationWithValue:(double)value fromValue:(double)fromValue duration:(CFTimeInterval)duration{
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (fromValue) {
        an.fromValue = @(fromValue);
    }
    an.toValue = @(value);
    an.removedOnCompletion = NO;
    an.fillMode = kCAFillModeForwards;
    an.duration = duration;
    return an;
}

//显示缓存的控制器
- (void)showData:(NSCache*)cache withKeyArr:(NSArray*)keyArr{
    
    CGRect rect = self.frame;
    self.data = [NSMutableArray new];
    for (NSString *key in keyArr) {
        NSDictionary *dic = [cache objectForKey:key];
         if (![dic objectForKey:@"hide"]||![[dic objectForKey:@"hide"] boolValue]) {
            [self.data addObject:[cache objectForKey:key]];
        }
    }
    self.hidden = YES;
    [faloatWindow addSubview:self.effectView];
    [faloatWindow addSubview:self.ta];
    
    self.cellHeight = (FloatHeight/2 - 50 - panSize)/5;
    
    CGFloat height = self.cellHeight*self.data.count+12*(self.data.count+1);
    CGFloat width = FloatWidth*0.66;
    CGRect tableViewRect = CGRectZero;
    tableViewRect.origin.x = rect.origin.x == 0?0:(FloatWidth-width);
    tableViewRect.origin.y = CGRectGetMaxY(rect);
    tableViewRect.size.width = width;
    tableViewRect.size.height = height;
    if (CGRectGetMaxY(tableViewRect)>FloatHeight) {
        tableViewRect.origin.y = CGRectGetMinY(rect) - height;
    }
    self.ta.frame = tableViewRect;
    self.ta.dataSource = self;
    self.ta.delegate = self;
    [self.ta reloadData];
}

//背景点击 关闭
- (void)effectViewAction{
    self.hidden = NO;
    [self.effectView removeFromSuperview];
    [self.ta removeFromSuperview];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WMZFloatPanHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WMZFloatPanHeadView"];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id dic = self.data[indexPath.section];
    WMZFloatPanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WMZFloatPanCell" forIndexPath:indexPath];
    cell.closeBtn.tag = indexPath.section + 100;
    [cell.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.left = (tableView.frame.origin.x == 0);
    cell.cellHeight = self.cellHeight;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        cell.name.text = dic[@"name"];
        if (dic[@"icon"]) {
            cell.icon.image = [UIImage imageNamed:dic[@"icon"]?:@"float_image"];
            cell.icon.backgroundColor = [UIColor clearColor];
        }else{
            cell.icon.image = [UIImage imageNamed:@"empty_image_no"];
            cell.icon.backgroundColor = FloatShowColor;
        }
    }else if ([dic isKindOfClass:[NSString class]]){
        cell.name.text = dic;
        cell.icon.image = [UIImage imageNamed:@"empty_image_no"];
        cell.icon.backgroundColor = FloatShowColor;
    }else{
        cell.icon.image = [UIImage imageNamed:@"empty_image_no"];
        cell.icon.backgroundColor = FloatShowColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id dic = self.data[indexPath.section];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        UIViewController *VC = dic[@"controller"];
        UIViewController *nowVC = [WMZFloatTool getCurrentVC];
    
        //检查是否已经出现 已经出现的删除后再push 确保只出现一个浮窗VC
        NSInteger existIndex = 0;
        NSInteger exist = NO;
        for (UIViewController *tmpVC in nowVC.navigationController.viewControllers) {
            NSString *tmpKey = [NSString stringWithFormat:@"%@-%p",NSStringFromClass([tmpVC class]),tmpVC];
            if (self.deleagte&&[self.deleagte respondsToSelector:@selector(checkCache:)]) {
                if ([self.deleagte checkCache:tmpKey]) {
                    exist = YES;
                    existIndex = [nowVC.navigationController.viewControllers indexOfObject:tmpVC];
                    break;
                }
            }
        }
        
        [nowVC.navigationController pushViewController:VC animated:YES];
        if (exist) {
            NSMutableArray *marr = [NSMutableArray arrayWithArray:nowVC.navigationController.viewControllers];
            [marr replaceObjectAtIndex:existIndex withObject:VC];
            [marr removeLastObject];
            nowVC.navigationController.viewControllers = [NSArray arrayWithArray:marr];
        }
        
        //更新缓存
        if (self.deleagte&&[self.deleagte respondsToSelector:@selector(hideCache:)]) {
           [self.deleagte hideCache:dic[@"key"]];
        }
        
        //关闭透明视图
        [self effectViewAction];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  self.cellHeight;
}


//删除
- (void)closeAction:(UIButton*)btn{
    
    id dic = self.data[btn.tag - 100];
    if ([self.data indexOfObject:dic]!=NSNotFound) {
        [self.data removeObject:dic];
    }
    
    [self changeTableViewFrame];
    
    if (self.deleagte&&[self.deleagte respondsToSelector:@selector(updateCache:)]) {
        [self.deleagte updateCache:dic[@"key"]];
    }
}

//改变frame
- (void)changeTableViewFrame{
    CGRect rect = self.ta.frame;
    rect.size.height = self.cellHeight*self.data.count+12*(self.data.count+1);
    self.ta.frame = rect;
    [self.ta reloadData];
}


- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

- (UIView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = faloatWindow.bounds;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(effectViewAction)];
        _effectView.userInteractionEnabled = YES;;
        [_effectView addGestureRecognizer:pan];
    }
    return _effectView;
}

- (UITableView *)ta{
    if (!_ta) {
        _ta = [[UITableView alloc]initWithFrame:CGRectMake(50, 100, 300, 400) style:UITableViewStyleGrouped];
        _ta.estimatedRowHeight = 0.01;
        _ta.estimatedSectionFooterHeight = 0.01;
        _ta.estimatedSectionHeaderHeight = 0.01;
        _ta.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ta.backgroundColor = [UIColor clearColor];
        [_ta registerClass:[WMZFloatPanHeadView class] forHeaderFooterViewReuseIdentifier:@"WMZFloatPanHeadView"];
        [_ta registerClass:[WMZFloatPanCell class] forCellReuseIdentifier:@"WMZFloatPanCell"];
        _ta.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _ta;
}

- (void)dealloc{
    
}

@end

@implementation WMZFloatPanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.icon = [UIImageView new];
        self.icon.layer.masksToBounds = YES;
        self.icon.image = [UIImage imageNamed:@"float_image"];
        [self.contentView addSubview:self.icon];
        
        self.name = [UILabel new];
        self.name.font = [UIFont systemFontOfSize:17.0f];
        self.name.numberOfLines = 2;
        [self.contentView addSubview:self.name];
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.closeBtn];
        [self.closeBtn setImage:[UIImage imageNamed:@"float_close"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
     [super layoutSubviews];
     CGFloat offset = 10;
     self.icon.frame = CGRectMake(offset, 0, 40, 40);
     self.name.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+offset, 0, self.frame.size.width-40-25-offset*4, 50);
     if (self.left) {
         self.closeBtn.frame = CGRectMake(self.frame.size.width-40-offset, 0, 40, 40);
         [WMZFloatTool setView:self Radii:CGSizeMake(self.cellHeight/2, self.cellHeight/2) RoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight shadom:YES];
     }else{
          self.closeBtn.frame = CGRectMake(self.frame.size.width-40-offset, 0, 40, 40);
          [WMZFloatTool setView:self Radii:CGSizeMake(self.cellHeight/2, self.cellHeight/2) RoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft shadom:YES];
     }
    self.icon.layer.cornerRadius = 20;
    self.name.center = CGPointMake(self.name.center.x, self.contentView.center.y);
    self.closeBtn.center = CGPointMake(self.closeBtn.center.x, self.contentView.center.y);
    self.icon.center = CGPointMake(self.icon.center.x, self.contentView.center.y);
}

@end

@implementation WMZFloatPanHeadView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
