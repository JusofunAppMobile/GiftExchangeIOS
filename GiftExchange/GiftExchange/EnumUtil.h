//
//  EnumUtil.h
//  GiftExchange
//
//  Created by JUSFOUN on 2018/4/25.
//  Copyright © 2018年 jusfoun. All rights reserved.
//

#ifndef EnumUtil_h
#define EnumUtil_h

typedef enum : NSUInteger {
    UserTypeBankStaff =1,//银行职员
    UserTypeLogistics,//物流
    UserTypeOrdinaryUser,//普通用户
    UserTypeAdmin,//管理员
    UserTypeBankAdmin,//银行管理员
} UserType;

#endif /* EnumUtil_h */
