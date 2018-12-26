//
//  CheckLogisticsController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CheckLogisticsController.h"

@interface CheckLogisticsController ()

@end

@implementation CheckLogisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"查看物流"];
    [self setBackBtn];
}

- (void)loadURL{
    NSString *path = [NSString stringWithFormat:@"%@/%@?nu=%@",KHTMLIP,KLogisticsDetail,_flowNo];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
