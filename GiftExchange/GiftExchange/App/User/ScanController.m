//
//  ScanController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ScanController.h"
#import "QRCodeScanController.h"
@interface ScanController ()

@end

@implementation ScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = KFrame(KDeviceW/2-50, 200, 100, 100);
    button.layer.borderColor = KRGB(86, 23, 122).CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:@"开始扫码" forState:UIControlStateNormal];
    [button setTitleColor:KRGB(56, 35, 76) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}


-(void)scan
{
    QRCodeScanController *vc = [[QRCodeScanController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
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
