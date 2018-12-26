//
//  ChangeLogisticsController.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^ChangeNoBlock)(NSString *no);

@interface ChangeLogisticsController : BasicViewController

@property (nonatomic ,copy) NSString *number;

@property (nonatomic ,copy) ChangeNoBlock  reloadBlock;

@property (nonatomic ,copy) NSString *pid;//订单id

@end
