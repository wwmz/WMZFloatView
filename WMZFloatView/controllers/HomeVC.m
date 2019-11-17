//
//  HomeVC.m
//  WMZFloatView
//
//  Created by wmz on 2019/11/9.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "HomeVC.h"
#import "WMZFloatViewConfig.h"
#import "ViewController.h"
#import "ProtocolVC.h"
#import "normalVC.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *taData;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *ta = [[UITableView alloc]initWithFrame:CGRectMake(0, FloatNavBarHeight, self.view.frame.size.width,self.view.frame.size.height-FloatNavBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    ta.estimatedRowHeight = 0.01;
    ta.estimatedSectionFooterHeight = 0.01;
    ta.estimatedSectionHeaderHeight = 0.01;
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taData[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.taData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = self.taData[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = dic[@"name"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic = self.taData[indexPath.section][indexPath.row];
    if (indexPath.section == 5) {
        //实现协议加入悬浮的控制器
        ProtocolVC *vc = [ProtocolVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 6){
        //不加入悬浮正常的控制器
        normalVC *vc = [normalVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //一开始就注册悬浮的控制器
        ViewController *vc = [ViewController new];
        vc.url = dic[@"url"];
        vc.message = dic[@"detail"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)taData{
    if (!_taData) {
        _taData = @
        [@[
            @{@"name":@"朋友圈",
              @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169405&di=c9d65fbe452639d40fc8c263164561d2&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F8af86840940cc3a7856a6531615980df001dc2a13df57-B5TvjT_fw658",
              @"detail":@"iOS WKWebView的使用"
            }
        ],
        @[
           @{@"name":@"支付",
             @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169404&di=850d0f6807d138e4b32accfd5194234f&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201510%2F17%2F20151017144429_hy2NC.jpeg",
             @"detail":@"的哥马汉峰,从业19载零差评"
           }
        ],
    @[
       @{
         @"name":@"扫一扫",
         @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169403&di=570ee65139fb92778854cbfff5494f7f&imgtype=0&src=http%3A%2F%2Fi.3454.com%2Fc%2F0903090807.jpg",
         @"detail":@"的哥马汉峰,从业19载零差评"
       },
       @{
           @"name":@"附近的人",
           @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169402&di=5ab7d8c6bfeb1b96889f7849058a38d4&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F263%2Fw640h423%2F20181027%2FLUGC-hnaivxp3907072.jpg",
           @"detail":@"他们曾是CBA最弱的鱼腩,如今却蜕变成凶狠的复仇者"
       }
    ],
        @[
  @{@"name":@"收藏",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169398&di=0081b78ec0c28a4db08cf674ef0840a6&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201406%2F26%2F20140626165001_8ARsz.jpeg",@"detail":@"李小璐厉害了,甜心理想,点圈中星二代那些事"},
  @{@"name":@"卡包",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169355&di=e1da7337d63f6a3d54afbbd0f0c95bb4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201802%2F19%2F20180219185335_CEUVZ.jpeg",@"detail":@"惩教飞虎队拟借调警队参与防暴 有监狱平乱经验"},
  @{@"name":@"相册",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169354&di=1e54fced28988fa74c363c83dba2fe1c&imgtype=0&src=http%3A%2F%2F05imgmini.eastday.com%2Fmobile%2F20181016%2F20181016213902_a204942a6ee07e6a04cb752f0b10f0fc_3.jpeg",@"detail":@"官员动歪心思多开票砸自己脚:购运景观石虚报费用"},
  @{@"name":@"设置",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169353&di=6511e5a06001997693189dcd13a24f18&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201711%2F03%2F20171103095014_K2NJd.jpeg",@"detail":@"外媒：逾八成全球投资者将增加对中国投资"}],
        @[@{@"name":@"小程序",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573989169350&di=87da801bfd930a21b8b91e46932c888c&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw700h528%2F20180122%2F2d7c-fyqwiqi3110904.jpg",@"detail":@"国家禁毒委:将以云南为主战场开展'净边2020'行动"}],
         
         @[@{@"name":@"实现协议加入悬浮的控制器"}],
         @[@{@"name":@"正常的控制器"}],
         
        ];
    }
    return _taData;
}
@end

