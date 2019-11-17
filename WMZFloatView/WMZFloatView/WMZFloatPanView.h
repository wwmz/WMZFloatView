//
//  WMZFloatPanView.h
//  WMZFloatView
//
//  Created by wmz on 2019/11/12.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZFloatViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZFloatPanCell : UITableViewCell
@property(nonatomic,assign)BOOL left;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIButton *closeBtn;
@end

@interface WMZFloatPanHeadView : UITableViewHeaderFooterView;
@end

@protocol WMZFloatDelegate <NSObject>
//删除cache
- (void)updateCache:(NSString*)key;
//更新cache
- (void)hideCache:(NSString*)key;
//检测缓存是否出现
- (BOOL)checkCache:(NSString*)key;
@end

@interface WMZFloatPanView : UIView
@property(nonatomic,weak)id<WMZFloatDelegate> deleagte;
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)UIVisualEffectView *effectView;
//显示缓存的控制器列表
- (void)showData:(NSCache*)cache withKeyArr:(NSArray*)keyArr;
//更新圆形图案 最大5个图案
- (void)updateBall:(NSCache*)cache withKeyArr:(NSArray*)keyArr;
//背景点击 关闭
- (void)effectViewAction;
@end

NS_ASSUME_NONNULL_END
