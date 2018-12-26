//
//  GiftExchangeModel.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface GiftExchangeModel : NSObject


@property(nonatomic,copy) NSString *pid;


@property(nonatomic,copy) NSString *no;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,strong)NSArray *imgs;

@property(nonatomic,copy) NSString *num;

@property(nonatomic,copy) NSString *time;

@property(nonatomic,copy) NSString *cardName;

@property(nonatomic,strong)AddressModel *addrInfo;

@property(nonatomic,copy) NSString *flowUrl;

@property(nonatomic,copy) NSString *flowNo;

@property(nonatomic,copy) NSString *detailUrl;

@property(nonatomic,copy) NSString *status;


@end
