//
//  UserPicker.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ReceptUserModel;

@protocol UserPickerDelegate <NSObject>

- (void)didSelectUserPicker:(ReceptUserModel *)model;

@end


@interface UserPicker : UIView

@property (nonatomic ,weak) id <UserPickerDelegate>delegate;

- (instancetype)initWithData:(NSArray *)datas;

- (void)show;

- (void)dismiss;

@end
