//
//  ConfirmExchangeControlle.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BasicViewController.h"

@class AddressModel;
@class ChooseGiftModel;
@class MyCardModel;
@interface ConfirmExchangeControlle : BasicViewController

@property (nonatomic ,strong) AddressModel *addrModel;//不为空则表示从确认兑奖进入，修改地址

@property (nonatomic ,strong) ChooseGiftModel *giftModel;//不为空则表示从确认兑奖进入，修改地址

@property (nonatomic ,strong) MyCardModel *cardModel;

@end
