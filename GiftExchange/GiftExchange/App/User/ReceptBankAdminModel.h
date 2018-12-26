//
//  ReceptBankAdminModel.h
//  GiftExchange
//
//  Created by JUSFOUN on 2018/4/25.
//  Copyright © 2018年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceptUserModel.h"

@interface ReceptBankAdminModel : NSObject

@property (nonatomic ,copy) NSString *pid;//银行id
@property (nonatomic ,copy) NSString *name;//银行
@property (nonatomic ,strong) NSArray *userList;//银行管理员列表
@end
