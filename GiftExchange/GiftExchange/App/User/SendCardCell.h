//
//  SendCardCell.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardManageModel;

@protocol AdminSendCardDelegate <NSObject>

- (void)adminDidTapSendCardBtn:(CardManageModel *)model;

@end

@interface SendCardCell : UITableViewCell

@property (nonatomic ,weak) id <AdminSendCardDelegate>delegate;

@property (nonatomic ,strong) CardManageModel *model;


@end
