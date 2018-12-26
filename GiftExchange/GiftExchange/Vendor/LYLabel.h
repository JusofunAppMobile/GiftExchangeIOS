//
//  LYLabel.h
//  PSBUIViewDemo
//
//  Created by ChangLuyang on 15/4/29.
//  Copyright (c) 2015年 PSB. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface LYLabel : UILabel
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;
@end
