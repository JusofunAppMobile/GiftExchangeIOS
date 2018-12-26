//
//  RecordController.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicViewController.h"
#import "RecordCell.h"
#import "GiftExchangeModel.h"
#import "EditAddressController.h"
#import "CheckLogisticsController.h"
#import "GiftDetailController.h"

@interface RecordController : BasicViewController<RecordCellDelegate>

@property (nonatomic ,assign) BOOL fromConfrimVC;//从确认兑换进入此页面，则返回的时候跳到前一个tab


@end
