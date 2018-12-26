//
//  CardManageCell.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CardManageModel;

@protocol SendCardDelegate <NSObject>

- (void)didTapSendCardButton:(CardManageModel *)model;
@end


@interface CardManageCell : UITableViewCell

@property (nonatomic ,weak) id <SendCardDelegate>delegate;

@property (nonatomic ,strong) CardManageModel *model;

@end
