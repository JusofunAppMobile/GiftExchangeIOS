//
//  EditAddressController.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import "AddressModel.h"

@class ChooseGiftModel;
@class MyCardModel;
typedef enum : NSUInteger {
    ControllerTypeEdit,//编辑地址
    ControllerTypeChange,//更改地址
    ControllerTypeRecord//兑换记录修改地址
} ControllerType;//判断是更改地址还是编辑地址

@interface EditAddressController : BasicViewController

@property (nonatomic ,strong) AddressModel *addrModel;//不为空则表示从确认兑奖进入，修改地址

@property (nonatomic ,strong) ChooseGiftModel *giftModel;//不为空则表示从确认兑奖进入，修改地址

@property (nonatomic ,strong) MyCardModel *cardModel;//电子券model,从ChooseGiftController传来，给确认礼品页面

@property (nonatomic ,assign) ControllerType type;//

@property (nonatomic ,copy) NSString *orderId;


@end
