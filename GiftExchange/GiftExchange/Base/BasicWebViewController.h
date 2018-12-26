//
//  BasicWebViewController.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicWebViewController : BasicViewController<UIWebViewDelegate>

@property (nonatomic ,strong) UIWebView *webView;

//加载url
- (void)loadURL;
@end
