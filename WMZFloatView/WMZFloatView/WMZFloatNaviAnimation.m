//
//  WMZFloatNaviAnimation.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZFloatNaviAnimation.h"

@implementation WMZFloatNaviAnimation

- (NSTimeInterval)transitionDuration:(id )transitionContext{
    return 0.5;
}

- (void)animateTransition:(id )transitionContext{
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
       UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
       UIView * containerView = [transitionContext containerView];
       UIView * fromView = fromVC.view;
       UIView * toView = toVC.view;
        
       [containerView addSubview:toView];
       [[transitionContext containerView] bringSubviewToFront:fromView];
        
       NSTimeInterval duration = [self transitionDuration:transitionContext];
       [UIView animateWithDuration:duration animations:^{
           fromView.alpha = 0.0;
           fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
           toView.alpha = 1.0;
       } completion:^(BOOL finished) {
           fromView.transform = CGAffineTransformMakeScale(1, 1);
            fromView.alpha = 1.0;
           [transitionContext completeTransition:YES];
       }];
}
@end


@implementation WMZFloatInteractivenimation

- (NSTimeInterval)transitionDuration:(id )transitionContext{
    return 0.5;
}

- (void)animateTransition:(id )transitionContext{
       UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
       UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
       UIView * containerView = [transitionContext containerView];
       UIView * fromView = fromVC.view;
       UIView * toView = toVC.view;
        
       [containerView addSubview:toView];
       [[transitionContext containerView] bringSubviewToFront:fromView];
        
       NSTimeInterval duration = [self transitionDuration:transitionContext];
       toView.transform = CGAffineTransformMakeScale(0.2, 0.2);
       toView.alpha = 0;
       [UIView animateWithDuration:duration animations:^{
           fromView.alpha = 0.5;
           toView.transform = CGAffineTransformMakeScale(1, 1);
           toView.alpha = 1.0;
       } completion:^(BOOL finished) {
           fromView.alpha = 1;
           [transitionContext completeTransition:YES];
       }];
}


@end
