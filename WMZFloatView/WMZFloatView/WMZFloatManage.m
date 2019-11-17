//
//  WMZFloatManage.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZFloatManage.h"
#import "WMZFloatNaviAnimation.h"
#import <UIKit/UIFeedbackGenerator.h>
#import "WMZFloatPanView.h"
#import "WMZFloatViewProtocol.h"
static WMZFloatManage* floatManage = nil;
@interface WMZFloatManage() <UINavigationControllerDelegate,UIGestureRecognizerDelegate,WMZFloatDelegate>
{
   BOOL isContains ;     //侧滑手势是否在圆圈范围内
}
@property(nonatomic,strong)NSMutableDictionary *reginerVCConfig;     //注册的可加入悬浮的控制器配置
@property(nonatomic,strong)NSMutableArray *reginerVCName;            //注册的可加入悬浮的控制器classname
@property(nonatomic,strong)CADisplayLink *link;                      //定时器
@property(nonatomic,strong)WMZFloatView *floatView;                  //圆圈部分
@property(nonatomic,strong)WMZFloatPanView *panView;                 //悬浮拖动视图
@property(nonatomic,strong)UIViewController *nowVC;                  //当前拖动的VC
@property(nonatomic,strong)NSCache *cache;                           //缓存控制器
@property(nonatomic,strong)NSMutableArray *cacheKey;                 //缓存控制器中的key 用于获取全部缓存
@property(nonatomic,assign)BOOL hadAnimal;                           //是否已经有触碰动画
@property(nonatomic,assign)CGRect normalRect;                        //floatView的起始frame
@property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *edge;   //侧滑手势
@end
@implementation WMZFloatManage
//单例
+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        floatManage = [[super allocWithZone:NULL] init] ;
        floatManage.popAnimal = [WMZFloatNaviAnimation new];
        floatManage.pushAnimal = [WMZFloatInteractivenimation new];
        UIViewController *currentVC = [WMZFloatTool getCurrentVC];
        currentVC.navigationController.delegate = floatManage;
        currentVC.navigationController.interactivePopGestureRecognizer.delegate = floatManage;
    }) ;
    
    return floatManage ;
}

//注册响应的controller
- (void)registerControllers:(NSArray*)controllers{
    for (id dic in controllers) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self.reginerVCConfig setObject:dic forKey:dic[@"controllerName"]];
            [self.reginerVCName addObject:dic[@"controllerName"]];
        }else if ([dic isKindOfClass:[NSString class]]) {
            [self.reginerVCConfig setObject:@{@"controllerName":dic} forKey:dic];
            [self.reginerVCName addObject:dic];
        }
    }
}


//监听侧滑手势开始
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]&&self.nowVC.navigationController.viewControllers.count>1) {
        //判断是否实现了协议 加入可悬浮
        BOOL isConform = [self.nowVC conformsToProtocol:@protocol(WMZFloatViewProtocol)];
        NSString *tmpName = NSStringFromClass([self.nowVC class]);
        if (isConform) {
            if ([self.reginerVCName indexOfObject:tmpName] == NSNotFound) {
                NSMutableDictionary *mdic = [NSMutableDictionary new];
                [mdic setObject:tmpName forKey:@"controllerName"];
                //实现了配置的协议 加入配置
                if ([self.nowVC respondsToSelector:@selector(floatViewConfig)]) {
                    NSDictionary *dic = [self.nowVC performSelector:@selector(floatViewConfig)];
                    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        [mdic setObject:obj forKey:key];
                    }];
                }
                [self.reginerVCName addObject:tmpName];
                [self.reginerVCConfig setObject:mdic forKey:tmpName];
            }
        }
        //达到可悬浮的条件
        if ([self.reginerVCName indexOfObject:tmpName] != NSNotFound && [self.cacheKey indexOfObject:[self getKey:self.nowVC]] == NSNotFound){
            self.edge = (UIScreenEdgePanGestureRecognizer *) gestureRecognizer;
            [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            [faloatWindow addSubview:self.floatView];
            self.normalRect = self.floatView.frame;
            CGRect rect = self.floatView.frame;
            rect.origin.x = FloatWidth;
            rect.origin.y = FloatHeight;
            self.floatView.frame = rect;
            self.floatView.full = (self.cacheKey.count>=5);
        }
        
    }
    return YES;
}

//侧滑手势
- (void)edgeAction:(CADisplayLink*)link{
    CGRect rect = self.floatView.frame;
    CGPoint tPoint = [self.edge translationInView:faloatWindow];
    CGPoint onPoint = [self.edge locationInView:faloatWindow];
    switch (self.edge.state) {
        case UIGestureRecognizerStateBegan:
        {
            rect.origin.x = FloatWidth;
            rect.origin.y = FloatHeight;
            self.hadAnimal = NO;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (tPoint.x>=FloatWidth*0.2&&tPoint.x<=FloatWidth*0.5) {
                CGFloat scale = (self.normalRect.size
                                 .width*tPoint.x)/(FloatWidth*0.3);
                rect.origin.x = FloatWidth - scale/2;
                rect.origin.y = FloatHeight - scale/2;
            }else if (tPoint.x>FloatWidth*0.5) {
                rect.origin.x = self.normalRect.origin.x;
                rect.origin.y = self.normalRect.origin.y;
            }else if (tPoint.x<FloatWidth*0.2) {
                rect.origin.x = FloatWidth;
                rect.origin.y = FloatHeight;
            }
            //是否触碰到悬浮框
            isContains = [WMZFloatTool point:onPoint inCircleRect:self.normalRect];
        }
            break;
        case UIGestureRecognizerStatePossible:{
            //需要储存
            [self.floatView removeFromSuperview];
            self.floatView = nil;
            
            [self.link invalidate];
            self.link = nil;
            
            if (self.hadAnimal&&isContains) {
                if (self.cacheKey.count>=5) {
                    __weak WMZFloatManage *weakManage = self;
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"浮窗已满,管理后可继续新增" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakManage panViewTapAction:nil];
                    }]];
                    [[WMZFloatTool getCurrentVC] presentViewController:alert animated:YES completion:nil];
                    return;
                }
                NSString *key = [self getKey:self.nowVC];;
                if (![self.cache objectForKey:key]) {
                    NSMutableDictionary *mdic = [NSMutableDictionary new];
                    [mdic setObject:self.nowVC forKey:@"controller"];
                    [mdic setObject:self.nowVC.title forKey:@"name"];
                    [mdic setObject:key forKey:@"key"];
                    if ([self.reginerVCConfig objectForKey:NSStringFromClass([self.nowVC class])]) {
                        NSDictionary *dic = [self.reginerVCConfig objectForKey:NSStringFromClass([self.nowVC class])];
                        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            [mdic setObject:obj forKey:key];
                        }];
                    }
                    [self.cache setObject:mdic forKey:key];
                    [self.cacheKey addObject:key];
                }
                if ([[faloatWindow subviews] indexOfObject:self.panView] == NSNotFound) {
                    [faloatWindow addSubview:self.panView];
                    self.panView.deleagte = self;
                    [self.panView updateBall:self.cache withKeyArr:self.cacheKey];
                }else{
                    [self.panView updateBall:self.cache withKeyArr:self.cacheKey];
                }
            }
            self.hadAnimal = NO;
            return;
        }
        default:
            break;
    }

    [UIView animateWithDuration:0.1 animations:^{
        self.floatView.frame = rect;
        if (self->isContains) {
            self.floatView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
            if (@available(iOS 10.0, *)) {
                if (!self.hadAnimal) {
                    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
                    [feedBackGenertor impactOccurred];
                }
            }
            self.hadAnimal = YES;
        }else{
            self.floatView.layer.transform = CATransform3DIdentity;
            self.hadAnimal = NO;
        }
    }];
    
    
}

//浮动视图点击方法
- (void)panViewTapAction:(UITapGestureRecognizer*)tap{
    [self.panView showData:self.cache withKeyArr:self.cacheKey];
}

#pragma -mark WMZFloatDelegate
- (void)updateCache:(NSString*)key{
    if ([self.cacheKey indexOfObject:key]!=NSNotFound) {
        [self.cacheKey removeObject:key];
        [self.cache removeObjectForKey:key];
        if (self.cacheKey.count == 0) {
            [self.panView effectViewAction];
            [self.panView removeFromSuperview];
            self.panView = nil;
        }
        [self.panView updateBall:self.cache withKeyArr:self.cacheKey];
    }
}

- (void)hideCache:(NSString*)key{
    if ([self.cacheKey indexOfObject:key]!=NSNotFound) {
        NSInteger count = 0;
        for (NSString *tmpKey in self.cacheKey) {
            NSDictionary *dic = [self.cache objectForKey:tmpKey];
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
            if ([tmpKey isEqualToString:key]) {
                [mdic setValue:@(YES) forKey:@"hide"];
            }else{
                [mdic setValue:@(NO) forKey:@"hide"];
                count+=1;
            }
            [self.cache setObject:[NSDictionary dictionaryWithDictionary:mdic] forKey:tmpKey];
        }
        
        if (count == 0) {
            [self.panView effectViewAction];
            [self.panView removeFromSuperview];
            self.panView = nil;
        }
        
        [self.panView updateBall:self.cache withKeyArr:self.cacheKey];
    }
}

- (BOOL)checkCache:(NSString*)key{
    BOOL exist = NO;
    if ([self.cacheKey indexOfObject:key]!=NSNotFound) {
        NSDictionary *dic = [self.cache objectForKey:key];
        if (dic[@"hide"]&&[dic[@"hide"] boolValue]) {
            exist = YES;
        }
    }
    return exist;
}

#pragma -mark navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.nowVC = viewController;
    NSString *key = [self getKey:viewController];
    if ([self.cacheKey indexOfObject:key] == NSNotFound) {
        NSInteger count = 0;
        for (NSString *tmpKey in self.cacheKey) {
             NSDictionary *dic = [self.cache objectForKey:tmpKey];
             NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
            if (mdic[@"hide"]&& [mdic[@"hide"] boolValue]) {
                count+=1;
                [mdic setValue:@(NO) forKey:@"hide"];
            }
            [self.cache setObject:[NSDictionary dictionaryWithDictionary:mdic] forKey:tmpKey];
        }
        if (count) {
            if ([faloatWindow.subviews indexOfObject:self.panView]==NSNotFound) {
                [faloatWindow addSubview:self.panView];
                self.panView.deleagte = self;
            }
            [self.panView updateBall:self.cache withKeyArr:self.cacheKey];
        }
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        if ([self.cacheKey indexOfObject:[self getKey:toVC]]!=NSNotFound) {
            return self.pushAnimal;
        }
    }else if (operation == UINavigationControllerOperationPop){
        if ([self.cacheKey indexOfObject:[self getKey:fromVC]]!=NSNotFound) {
            return self.popAnimal;
        }
    }
    
    return nil;
}

//获取唯一key 控制器的地址+控制器的className
- (NSString*)getKey:(UIViewController*)vc{
   return [NSString stringWithFormat:@"%@-%p",NSStringFromClass([vc class]),vc];
}


- (NSMutableArray *)reginerVCName{
    if (!_reginerVCName) {
        _reginerVCName = [NSMutableArray new];
    }
    return _reginerVCName;
}

- (NSMutableDictionary *)reginerVCConfig{
    if (!_reginerVCConfig) {
        _reginerVCConfig = [NSMutableDictionary new];
    }
    return _reginerVCConfig;
}

- (CADisplayLink *)link{
     if (!_link) {
         _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(edgeAction:)];
     }
    return _link;
}

- (WMZFloatView *)floatView{
    if (!_floatView) {
        _floatView = [WMZFloatView new];
    }
    return _floatView;
}

- (WMZFloatPanView *)panView{
    if (!_panView) {
        _panView = [WMZFloatPanView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panViewTapAction:)];
        [_panView addGestureRecognizer:tap];
    }
    return _panView;
}

- (NSMutableArray *)cacheKey{
    if (!_cacheKey) {
        _cacheKey = [NSMutableArray new];
    }
    return _cacheKey;
}

- (NSCache *)cache{
    if (!_cache) {
        _cache = [NSCache new];
        _cache.countLimit = 5;
    }
    return _cache;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [WMZFloatManage shareInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [WMZFloatManage shareInstance] ;
}

@end
