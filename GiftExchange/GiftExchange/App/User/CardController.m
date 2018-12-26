//
//  CardController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CardController.h"
#import "MyCardModel.h"
#import "ChooseGiftModel.h"

@interface CardController ()

@property (nonatomic ,strong) NSArray *datalist;

@property (nonatomic ,strong) MyCardModel *cardModel;//输入卡的信息

@property (nonatomic ,copy) NSString *code;

@property (nonatomic ,copy) NSString *pwd;

@end

@implementation CardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawView];
    
    [self setNavigationBarTitle:@"卡密兑换"];
    [self setBackBtn];
    
}

-(void)drawView
{
    KWeakSelf;
    CardView *view = [[CardView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH-KNavigationBarHeight)];//UIRectEdgeNone导航栏以下开始布局
    view.resultBlock = ^(NSString *code,NSString *pwd){
        weakSelf.code = code;
        weakSelf.pwd = pwd;
        [weakSelf loadData];
    };
    [self.view addSubview:view];
}


#pragma mark 请求数据
- (void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_code forKey:@"cardNo"];
    [params setObject:_pwd forKey:@"cardPwd"];

    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KSearchGiftListByCardNo parameters:params  success:^(id responseObject) {
        
        [MBProgressHUD hideHudToView:nil animated:YES];

        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.datalist = [ChooseGiftModel mj_objectArrayWithKeyValuesArray:
                                 responseObject[@"data"][@"list"]];
            weakSelf.cardModel = [MyCardModel mj_objectWithKeyValues:
                                  responseObject[@"data"][@"cardInfo"]];
            [weakSelf jumpToChooseGiftVc];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

#pragma mark - 跳转礼品选择页面
- (void)jumpToChooseGiftVc{

    if (![_cardModel.cardPwd isEqualToString:_pwd]) {
        [MBProgressHUD showError:@"卡号或密码错误！" toView:nil];
        return;
    }
    if ([_cardModel.status intValue] == 1) {
        [MBProgressHUD showError:@"卡券已兑换！" toView:nil];
        return;
    }
    if ([_cardModel.status intValue] == 2) {
        [MBProgressHUD showError:@"卡券已过期！" toView:nil];
        return;
    }
    ChooseGiftController *vc = [[ChooseGiftController alloc]init];
    vc.cardModel = _cardModel;
    vc.datalist = _datalist;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
