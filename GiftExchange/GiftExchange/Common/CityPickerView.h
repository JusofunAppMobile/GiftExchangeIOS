//
//  CityPickerView.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityPickerDelegate <NSObject>

- (void)cityPickerDidSelectWithAddress:(NSString *)addr;

@end

@interface CityPickerView : UIView

@property (nonatomic ,weak) id <CityPickerDelegate>delegate;
- (void)show;

- (void)dismiss;

@end
