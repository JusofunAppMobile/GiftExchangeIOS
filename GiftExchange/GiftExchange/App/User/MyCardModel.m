//
//  MyCardModel.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "MyCardModel.h"

@implementation MyCardModel

- (NSString *)cardPwd{
    if (!_cardPwd||[_cardPwd isKindOfClass:[NSNull class]]) {
        _cardPwd = @"";
    }
    return _cardPwd;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"pid":@"cardTypeId"};
}

@end
