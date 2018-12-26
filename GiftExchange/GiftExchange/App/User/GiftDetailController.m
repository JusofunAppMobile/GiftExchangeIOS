//
//  GiftDetailController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "GiftDetailController.h"

@interface GiftDetailController ()

@end

@implementation GiftDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBtn];
    [self setNavigationBarTitle:@"礼品详情"];
}

- (void)loadURL{
    
//    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@prizeDetails.html?pid=%@",_pid]];
//    NSString *path = [NSString stringWithFormat:@"%@/%@pid=%@",KHTMLIP,KGiftList,_pid];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:req];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
