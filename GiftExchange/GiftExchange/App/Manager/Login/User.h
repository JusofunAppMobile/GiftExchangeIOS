//
//  User.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JKDBModel.h>
#import "AddressModel.h"

@interface User : JKDBModel


@property (nonatomic ,copy) NSString *phone;

@property (nonatomic ,copy) NSString *type;

@property (nonatomic ,copy) NSString *userId;

@property (nonatomic ,assign) BOOL isLogin;

@property (nonatomic ,strong) AddressModel  *addrInfo;

SingletonH(User)

+ (void)cleanUser;
@end
