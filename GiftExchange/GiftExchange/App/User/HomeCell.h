//
//  HomeCell.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/8.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCellModel;
@interface HomeCell : UITableViewCell

- (void)loadCellWithModel:(HomeCellModel *)model;

@end
