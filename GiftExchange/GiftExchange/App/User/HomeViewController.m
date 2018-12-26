//
//  HomeViewController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/2.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "HomeViewController.h"
#import "CardTypeModel.h"

#import "HomeListController.h"
#import "ExchangeRuleController.h"

#import "HomeCellModel.h"
#import "HomeTabModel.h"


static NSString *HomeCellId = @"HomeCell";

@interface HomeViewController ()

@property (nonatomic ,strong) NSArray *cardTypes;
@property (nonatomic ,strong) NSArray *giftList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"卡券介绍"];
    [self setRightNavigationBarBtnWithTitle:@"兑奖规则" withImageName:nil];
    
    [self loadData];
}

- (void)addChildViewController{
    for (int i = 0; i < self.vcTitleArr.count; i++) {
        
        HomeTabModel *model = self.vcTitleArr[i];
        
        HomeListController * vc = [[HomeListController alloc] init];

        vc.title                = model.name;
        
        vc.pid = model.pid;
        
        if (i == 0) {
            vc.giftList = [_giftList copy];
        }

        [self addChildViewController:vc];
    }
}

#pragma mark - 兑奖规则
- (void)rightBtnAction{
    NSLog(@"兑奖规则");
    ExchangeRuleController *vc = [ExchangeRuleController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 网络请求
- (void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"type"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KGiftList parameters:params  success:^(id responseObject) {
       
        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.giftList = [HomeCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            weakSelf.vcTitleArr = [HomeTabModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cardTypeList"]];
            [weakSelf reloadView];
            [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:weakSelf.view];
        }
        [weakSelf hideNetFailView];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        [weakSelf showNetFailWithFrame:CGRectMake(0,  0, KDeviceW, KDeviceH-KNavigationBarHeight - KTabBarHeight)];
    }];
}

- (void)reloadView{
    [self initializeLinkageListViewController];
}

#pragma mark - 网络异常
- (void)netFailReload{
    
    [self loadData];
}

@end
