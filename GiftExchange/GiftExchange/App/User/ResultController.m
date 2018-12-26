//
//  ResultController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ResultController.h"

@interface ResultController ()

@end

@implementation ResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(10, 150, KDeviceW - 20, 50)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderColor = KRGB(86, 23, 122).CGColor;
    label.layer.borderWidth = 1;
    [self.view addSubview:label];
    
    if(self.resultArray.count >0)
    {
        AVMetadataMachineReadableCodeObject *obj = _resultArray[0];
        label.text = [obj stringValue];
    }
    else
    {
        label.text = @"无结果";
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
