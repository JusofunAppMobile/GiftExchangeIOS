//
//  ReceptUserModel.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceptUserModel : NSObject

@property (nonatomic ,copy) NSString *pid;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *num;//发卡数量

@property (nonatomic ,copy) NSString *bankID;//银行id

@property (nonatomic ,copy) NSString *bankName;

@end
