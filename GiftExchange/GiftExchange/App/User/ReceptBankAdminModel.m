//
//  ReceptBankAdminModel.m
//  GiftExchange
//
//  Created by JUSFOUN on 2018/4/25.
//  Copyright © 2018年 jusfoun. All rights reserved.
//

#import "ReceptBankAdminModel.h"

@implementation ReceptBankAdminModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"userList":ReceptUserModel.class};
}

@end
