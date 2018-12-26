//
//  BaseSegmentController.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface BaseSegmentController : BasicViewController

@property (strong, nonatomic) NSArray *vcTitleArr;

-(void)addChildViewController;

-(void)initializeLinkageListViewController;

@end
