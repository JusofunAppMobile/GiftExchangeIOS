//
//  ExchangeRuleController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ExchangeRuleController.h"

@interface ExchangeRuleController ()

@end

@implementation ExchangeRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    [self setNavigationBarTitle:@"兑奖规则"];
}

- (void)loadURL{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",KHTMLIP,KRules];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:req];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
