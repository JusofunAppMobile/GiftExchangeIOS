//
//  BasicWebViewController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicWebViewController.h"

@interface BasicWebViewController ()

@end

@implementation BasicWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, KDeviceH-KNavigationBarHeight)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [MBProgressHUD showMessag:@"" toView:nil];
    
    [self loadURL];

    // Do any additional setup after loading the view.
}

#pragma mark 加载url
- (void)loadURL{
    
    
}

#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self hideNetFailView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHudToView:KeyWindow animated:NO];
    [self hideNetFailView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHudToView:KeyWindow animated:NO];
    [self showNetFailWithFrame:self.webView.frame];
}

- (void)netFailReload{
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
