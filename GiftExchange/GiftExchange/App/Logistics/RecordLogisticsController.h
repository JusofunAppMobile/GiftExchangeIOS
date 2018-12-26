//
//  RecordLogisticsController.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicViewController.h"
#import "ScanView.h"

typedef void(^ScanBlock)(NSString*resultStr);

@interface RecordLogisticsController : BasicViewController

@property (nonatomic ,copy) ScanBlock  scanBlock;

@end
