//
//  ChooseGiftController.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@class MyCardModel;
@interface ChooseGiftController : BasicViewController

@property (nonatomic ,strong) MyCardModel *cardModel;

@property (nonatomic ,strong) NSArray *datalist;

@end
