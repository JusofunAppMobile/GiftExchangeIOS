//
//  CustomAlertView.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertDelegate <NSObject>

- (void)dismissWithAssureButton;

@end

@interface CustomAlertView : UIView

@property (nonatomic ,weak) id <CustomAlertDelegate>delegate;

@property (nonatomic ,copy) NSString *icon;

@property (nonatomic ,copy) NSString *message;

- (instancetype)initWithMessage:(NSString *)msg icon:(NSString *)imageName;

- (void)show;

- (void)dismiss;

@end
