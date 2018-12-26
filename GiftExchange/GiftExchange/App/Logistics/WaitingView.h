//
//  WaitingView.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LogisticsBlock)(NSString*str);

@interface WaitingView : UIView


@property(nonatomic,copy)LogisticsBlock logisticsBlock;


-(instancetype)init;

-(void)show;

-(void)dismiss;
@end
