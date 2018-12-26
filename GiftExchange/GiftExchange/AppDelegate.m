//
//  AppDelegate.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "AppDelegate.h"
#import "Message.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LoginViewController.h"
#import "BasicNavigationController.h"


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [KNotificationCenter addObserver:self selector:@selector(checkLogin) name:KChangeRoot object:nil];
    [self checkLogin];
    [self setIQKeyboardManager];
//    [self configRemoteNoti];
    [self configGDLocation];//高德定位
    
    [self setUmeng];
    
    [self.window makeKeyAndVisible];

    return YES;
}

//是否第一次启动
- (BOOL)checkFirstLaunch{
    //第一次启动时，会创建“everUsed”键值，并默认为假
    NSString *str = [NSString stringWithFormat:@"isFirstUse%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    if (![KUserDefaults boolForKey:str]){
        
        [KUserDefaults setBool:YES forKey:str];
        [KUserDefaults synchronize];
        [self setGuideViewController];
        return YES;
    }else{
        [self checkLogin];
        return NO;
    }
}

- (void)checkLogin{

//    NSArray *array = [User findAll];
//    if(array.count>0)
//    {
//        User *user ;
//        user = [array objectAtIndex:0];
////        if ([KUSER isLogin])
////        {
////            [self setRootViewController];
////        }
//    }
//    else
//    {
//        [self setLoginController];
//    }
    [self setRootViewController];
}

//切换控制器
//主页
-(void)setRootViewController{
    
    if (_rootNavi) {
        [_rootNavi popToRootViewControllerAnimated:NO];
        _rootNavi = nil;
    }
    
    NSArray *array = [User findAll];
    if(array.count>0)
    {
        User *user ;
        user = [array objectAtIndex:0];
        //        if ([KUSER isLogin])
        //        {
        //            [self setRootViewController];
        //        }
    }
    _rootTabController = [[CustomTabBarController alloc]init];
    
    _rootNavi = [[BasicNavigationController alloc]initWithRootViewController:_rootTabController];
    _rootNavi.navigationBarHidden = YES;
  
    typedef void (^Animation)(void);
    
    _rootTabController.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
    
    Animation animation = ^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        
        [UIView setAnimationsEnabled:NO];
        
        self.window.rootViewController = _rootNavi;
        
        [UIView setAnimationsEnabled:oldState];
        
    };
    

    [UIView transitionWithView:self.window
     
                     duration:0.9f
     
                      options:UIViewAnimationOptionTransitionFlipFromRight
     
                   animations:animation
     
                   completion:nil];
    
    
}

//引导页
- (void)setGuideViewController{
    GuideController *view  = [[GuideController alloc]init];
    self.window.rootViewController = view;
}

//登录
- (void)setLoginController{
    
    
    LoginViewController *vc = [LoginViewController new];
    BasicNavigationController *navi = [[BasicNavigationController alloc] initWithRootViewController:vc];
   
    typedef void (^Animation)(void);
    
    navi.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
    
    Animation animation = ^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        
        [UIView setAnimationsEnabled:NO];
        
        self.window.rootViewController = navi;
        
        [UIView setAnimationsEnabled:oldState];
        
    };
    
    
    [UIView transitionWithView:self.window
     
                      duration:0.9f
     
                       options:UIViewAnimationOptionTransitionFlipFromLeft
     
                    animations:animation
     
                    completion:nil];

    
    
}

//推送
- (void)configRemoteNoti{
    [Message registerRemoteNotification:self];
}
//高德地图
- (void)configGDLocation{
    [AMapServices sharedServices].apiKey = MAP_KEY;
}

#pragma mark - 友盟
-(void)setUmeng
{
    UMConfigInstance.appKey = UMOB_Appkey;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.eSType = E_UM_NORMAL;
    [MobClick startWithConfigure:UMConfigInstance];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

#pragma mark - 自动隐藏键盘的第三方类库
-(void)setIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldShowTextFieldPlaceholder = NO;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"Device Token: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


//普通推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"123");
}

//静默推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"456");

}

//app处于前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSLog(@"789");
}

//点击通知进入
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{

    NSLog(@"abc");
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
