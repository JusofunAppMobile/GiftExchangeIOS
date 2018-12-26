//
//  ExchangeController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/8.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ExchangeController.h"
#import "AppDelegate.h"
#import "RecordController.h"
#import "ChooseGiftModel.h"
#import "MyCardModel.h"

@interface ExchangeController ()
{
    ScanView *scanView;
}
@property (nonatomic ,strong) NSArray *datalist;

@property (nonatomic ,strong) MyCardModel *cardModel;//输入卡的信息

@property (nonatomic ,copy) NSString *qrMd5;//扫码结果

@end

@implementation ExchangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"扫一扫兑奖"];
    [self setBackBtn];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self drawView];
}


-(void)useCard
{
    CardController *vc = [[CardController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)drawView
{
    KWeakSelf//比例是按全屏去算的
    scanView = [[ScanView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH) resultBlock:^(NSArray *resulutArray) {
        if(resulutArray.count >0)
        {
            AVMetadataMachineReadableCodeObject * metadataObject = [resulutArray objectAtIndex:0];
            [weakSelf getCardNoWithResult:metadataObject.stringValue];
        }
    }];
    [self.view addSubview:scanView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = KFrame(48, scanView.height - 35 - 40, KDeviceW - 48*2, 40);
    [button setTitle:@"卡密兑奖" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(useCard) forControlEvents:UIControlEventTouchUpInside];
    [scanView addSubview:button];
    
}

#pragma mark - 获取卡号和密码
- (void)getCardNoWithResult:(NSString *)result{
    _qrMd5 = [self getNo:result];
    [self loadData];
    
    return;
    
    if ([result containsString:KHostIP]) {
        _qrMd5 = [self getNo:result];
        [self loadData];
    }else{
        [MBProgressHUD showError:@"二维码格式不正确！" toView:nil];
        [self back];
    }
}

- (NSString *)getNo:(NSString *)result{
    NSArray *strings = [result componentsSeparatedByString:@"?"];
    NSArray *params = [(NSString *)strings[1] componentsSeparatedByString:@"&"];
    for (NSString *str in params) {
        if ([str containsString:@"card="]) {
            NSString *card = [str stringByReplacingOccurrencesOfString:@"card=" withString:@""];
            return card;
        }
    }
    return @"";
}
#pragma mark 请求卡券信息
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_qrMd5 forKey:@"qrcode"];
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KSearchGiftListByQRCode parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        
        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.datalist = [ChooseGiftModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            weakSelf.cardModel = [MyCardModel mj_objectWithKeyValues:responseObject[@"data"][@"cardInfo"]];
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
    
    if (!_cardModel.cardNo) {
        [MBProgressHUD showError:@"卡券不存在！" toView:nil];
        [self back];
        return;
    }
    
    if ([_cardModel.status intValue] == 0) {
        ChooseGiftController *vc = [[ChooseGiftController alloc]init];
        vc.cardModel = _cardModel;
        vc.datalist = _datalist;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([_cardModel.status intValue] == 2){
        [MBProgressHUD showError:@"卡券已过期！" toView:nil];
        [self back];
    }else{
        [MBProgressHUD showError:@"卡券已兑换！" toView:nil];
        [self back];
    }
    
}

#pragma mark - ♻️

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
   [scanView startScanAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [scanView stopScanAnimation];

}


-(void)dealloc
{
    [scanView removeScanningView];
}


- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"RecordController")]) {
            return;
        }
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

//会阻止viewWillAppear等类似方法的调用
//- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated{
//    if (isAppearing) {
//       self.navigationController.navigationBarHidden = NO;
//
//    }else{
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
