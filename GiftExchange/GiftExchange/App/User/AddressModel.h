//
//  AddressModel.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JKDBModel.h>

@interface AddressModel : JKDBModel

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *phone;

@property (nonatomic ,copy) NSString *addrDetail;

@property (nonatomic ,copy) NSString *addr;

@end
