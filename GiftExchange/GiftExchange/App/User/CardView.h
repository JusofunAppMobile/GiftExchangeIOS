//
//  CardView.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultBlock)(NSString *code,NSString *pwd);

@interface CardView : UIView

@property(nonatomic,copy)ResultBlock resultBlock;

@end
