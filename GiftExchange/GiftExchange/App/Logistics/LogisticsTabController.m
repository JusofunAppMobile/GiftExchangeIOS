//
//  LogisticsTabController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "LogisticsTabController.h"
#import "WaitingController.h"
#import "BasicNavigationController.h"
#import "SendController.h"

@interface LogisticsTabController ()

@end

@implementation LogisticsTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTabbarController{

    WaitingController * vc1 = [WaitingController new];
    vc1.title = @"待发货";
    vc1.tabBarItem.selectedImage =[self getOriginalImage:@"首页icon选中"];
    vc1.tabBarItem.image =[self getOriginalImage:@"首页icon默认"];
    
    BasicNavigationController *homeNavi=[[BasicNavigationController alloc]initWithRootViewController:vc1];
    
    SendController * vc2= [[SendController alloc]init];
    vc2.title = @"已发货";
    vc2.tabBarItem.selectedImage =[self getOriginalImage:@"兑奖icon选中"];
    vc2.tabBarItem.image =[self getOriginalImage:@"兑奖icon默认"];
    
    BasicNavigationController *exNavi=[[BasicNavigationController alloc]initWithRootViewController:vc2];
    
    self.viewControllers = @[homeNavi,exNavi];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end
