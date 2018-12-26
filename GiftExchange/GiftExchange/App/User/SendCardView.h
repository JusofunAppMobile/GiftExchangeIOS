//
//  SendCardView.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ReceptUserModel;

@protocol SendCardCommitDelegate <NSObject>

- (void)commitWithUser:(ReceptUserModel *)model;

@end

@interface SendCardView : UIView

@property (nonatomic ,weak) id <SendCardCommitDelegate>delegate;

@property (nonatomic ,strong) NSArray *models;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
