//
//  WMZFloatViewProtocol.h
//  WMZFloatView
//
//  Created by wmz on 2019/11/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

//只需要实现协议即可 协议中的方法是可选实现的
@protocol WMZFloatViewProtocol <NSObject>
@optional
/*
 *侧滑加入悬浮的其他配置 (name,image或其他配置)
 */
- (NSDictionary*)floatViewConfig;

@end

NS_ASSUME_NONNULL_END
