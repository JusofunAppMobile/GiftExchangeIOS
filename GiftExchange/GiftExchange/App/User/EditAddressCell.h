//
//  EditAddressCell.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LocateDelegate <NSObject>

- (void)didTapLocateButton;

- (void)cellDidEndEditingWithText:(NSString *)text index:(NSInteger)index;

@end

@class  AddressModel;

@interface EditAddressCell : UITableViewCell

@property (nonatomic ,weak) id <LocateDelegate>delegate;

- (void)loadCell:(AddressModel *)model index:(NSInteger)index;

@end
