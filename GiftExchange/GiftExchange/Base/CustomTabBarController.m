//
//  CustomTabBarController.m
//  PollsCloud
//
//  Created by lp_develop on 16/11/8.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "CustomTabBarController.h"
#import "BasicNavigationController.h"
#import "HomeViewController.h"
#import "ExchangeController.h"
#import "UserCenterController.h"

#import "CheckController.h"
#import "DeliveryController.h"
#import "ShippedController.h"

#import "WaitingController.h"
#import "SendController.h"
#import "CustomTabBar.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface CustomTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic ,strong) HomeViewController *homeVc;
@property (nonatomic ,strong) ExchangeController *exchangeVc;
@property (nonatomic ,strong) UserCenterController *userVc;
@property (nonatomic ,strong) UIViewController *blankVc;

@property (nonatomic ,strong) BasicNavigationController *homeNavi;
@property (nonatomic ,strong) BasicNavigationController *userNavi;


@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [self setTabbarController];
    [self setTabBarAppearance];
    // Do any additional setup after loading the view.
}

- (void)setCustomBar{

//    CustomTabBar *tabBar = [[CustomTabBar alloc]init];
//    [self setValue:tabBar forKey:@"tabBar"];
    
    self.delegate = self;
}

-(void)setTabbarController{
    
    [self setCustomBar];

    
    _homeVc= [HomeViewController new];
    _homeVc.title = @"首页";
    _homeVc.tabBarItem.selectedImage =[self getOriginalImage:@"首页icon选中"];
    _homeVc.tabBarItem.image =[self getOriginalImage:@"首页icon默认"];
    _homeNavi=[[BasicNavigationController alloc]initWithRootViewController:_homeVc];
    
    
    _blankVc = [BasicViewController new];
    _blankVc.title = @"兑奖";
    _blankVc.tabBarItem.image = [self getOriginalImage:@"兑奖icon默认"];
    
    
    
    _userVc=[[UserCenterController alloc]init];
    _userVc.title = @"我";
    _userVc.tabBarItem.selectedImage = [self getOriginalImage:@"用户icon选中"];
    _userVc.tabBarItem.image =[self getOriginalImage:@"用户icon默认"];
    _userNavi =[[BasicNavigationController alloc]initWithRootViewController:_userVc];
    
    self.viewControllers = @[_homeNavi,_blankVc,_userNavi];

}

- (UIImage *)getOriginalImage:(NSString *)imageName{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImage *image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


- (void)setTabBarAppearance{
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBHex(@"#5b5b5b")}
                                            forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBHex(@"#ff0000")}
                                            forState:UIControlStateSelected];
    [[UITabBar appearance]setTranslucent:NO];
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isEqual:_blankVc]) {
        if ([self checkLogin]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app.rootNavi pushViewController:self.exchangeVc animated:YES];
        }
        return NO;
    }
    if ([viewController isEqual:_userNavi]) {
        
        return [self checkLogin];
    }
    return YES;
}


- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (BOOL)checkLogin{
    if (![KUSER isLogin]) {
        LoginViewController *vc = [LoginViewController new];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.rootNavi pushViewController:vc animated:YES];
//        [app setLoginController];
        return NO;
    }
    return YES;
}

#pragma lazy load
- (ExchangeController *)exchangeVc{
    if (!_exchangeVc) {
        _exchangeVc = [ExchangeController new];
    }
    return _exchangeVc;
}

//-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    if (self.tabBar.frame.size.height == 83) {
//        NSLog(@"123");
//        CGRect tabFrame = self.tabBar.frame;
//        tabFrame.size.height = 49;
//        self.tabBar.frame = tabFrame;
//        self.tabBar.barStyle = UIBarStyleDefault;
//    }
//
//}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//    for (UIView *view in self.view.subviews) {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            //此处注意设置 y的值 不要使用屏幕高度 - 49 ，因为还有tabbar的高度 ，用当前tabbarController的View的高度 - 49即可
//            view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-49, view.frame.size.width, 49);
//        }
//    }
//    // 此处是自定义的View的设置 如果使用了约束 可以不需要设置下面,_bottomView的frame
//}

@end
