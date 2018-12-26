//
//  CardManageView.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardCommitDelegate <NSObject>

- (void)didTapCommitBtnWithPhone:(NSString *)phone name:(NSString *)name;

@end
@interface CardManageView : UIView

@property (nonatomic ,weak) id <CardCommitDelegate>delegate;
- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
