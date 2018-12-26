//
//  GuideController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "GuideController.h"

@interface GuideController ()
{
    UIScrollView *backScrollView;
}
@end

@implementation GuideController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, KDeviceH)];
    backScrollView.pagingEnabled = YES;
    
    backScrollView.showsVerticalScrollIndicator = NO;
    backScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:backScrollView];
    
    
    
    NSMutableArray *imageArray ;
    
    if(KScreen35)
    {
        imageArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    }
    else if ( KScreen4)
    {
        imageArray = [NSMutableArray arrayWithObjects:@"11",@"12",@"13", nil];
        
    }
    else if (KScreen47)
    {
        imageArray = [NSMutableArray arrayWithObjects:@"21",@"22",@"23",nil];
        
    }
    else
    {
        imageArray = [NSMutableArray arrayWithObjects:@"31",@"32",@"33", nil];
        
    }
    
    
    
    for(int i = 0;i<imageArray.count ;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KDeviceW *i,0, KDeviceW, KDeviceH)];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [backScrollView addSubview:imageView];
        if(i != imageArray.count-1)
        {
            UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
            [jumpBtn setTitleColor:KRGB(207, 237, 255) forState:UIControlStateNormal];
            [jumpBtn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
            jumpBtn.frame = KFrame(KDeviceW - 50 - 16, 20, 50, 30);
            // [imageView addSubview:jumpBtn];
        }
        
        if(i == imageArray.count-1)
        {
            UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
            loginButton.frame = CGRectMake((KDeviceW - KDeviceW *200/320)/2 , KDeviceH -30*KDeviceW/320-60/2*KDeviceW/320-28, KDeviceW *200/320 , 38*KDeviceW/320);
            loginButton.backgroundColor = [UIColor clearColor];
            [loginButton addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:loginButton];
            
        }
    }
    
    
    backScrollView.contentSize = CGSizeMake(KDeviceW *imageArray.count, 0);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goNext
{
    [KNotificationCenter postNotificationName:KChangeRoot object:self];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
