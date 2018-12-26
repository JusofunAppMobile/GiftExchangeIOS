//
//  AppDelegate.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuideController.h"
#import "CustomTabBarController.h"
#import "BasicNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic ,strong) CustomTabBarController *rootTabController;
@property (nonatomic ,strong) BasicNavigationController *rootNavi;


- (void)setRootViewController;
- (void)setLoginController;
@end

