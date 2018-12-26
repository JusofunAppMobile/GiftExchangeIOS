//
//  ManagerTabController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ManagerTabController.h"
#import "CheckController.h"
#import "DeliveryController.h"
#import "ShippedController.h"
#import "BasicNavigationController.h"



@interface ManagerTabController ()

@end

@implementation ManagerTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTabbarController{

    CheckController * vc1 = [CheckController new];
    vc1.title = @"待审核";
    vc1.tabBarItem.selectedImage =[self getOriginalImage:@"首页icon选中"];
    vc1.tabBarItem.image =[self getOriginalImage:@"首页icon默认"];
    
    BasicNavigationController *homeNavi=[[BasicNavigationController alloc]initWithRootViewController:vc1];
    
    DeliveryController * vc2=[[DeliveryController alloc]init];
    vc2.title = @"待发货";
    vc2.tabBarItem.selectedImage =[self getOriginalImage:@"兑奖icon选中"];
    vc2.tabBarItem.image =[self getOriginalImage:@"兑奖icon默认"];
    
    BasicNavigationController *exNavi=[[BasicNavigationController alloc]initWithRootViewController:vc2];
    
    ShippedController *vc3 =[[ShippedController alloc]init];
    vc3.title = @"已发货";
    vc3.tabBarItem.selectedImage = [self getOriginalImage:@"用户icon选中"];
    vc3.tabBarItem.image =[self getOriginalImage:@"用户icon默认"];
    
    BasicNavigationController *userNavi =[[BasicNavigationController alloc]initWithRootViewController:vc3];
    
    self.viewControllers = @[homeNavi,exNavi,userNavi];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
