//
//  CheckView.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CheckType) {
    CheckPass       = 1,
    CheckReject     = 2
   
};

typedef void(^CheckBlock)(CheckType);

@interface CheckView : UIView

@property(nonatomic,copy)CheckBlock checkBlock;



-(instancetype)init;

-(void)show;

-(void)dismiss;


@end
