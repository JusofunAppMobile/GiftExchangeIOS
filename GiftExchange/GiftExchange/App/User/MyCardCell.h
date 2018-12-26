//
//  MyCardCell.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCardModel;
@interface MyCardCell : UITableViewCell

- (void)loadCell:(MyCardModel *)model;

@end
