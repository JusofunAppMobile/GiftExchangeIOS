//
//  SearchNoResultView.m
//  RecruitOnline
//
//  Created by JUSFOUN on 2017/6/28.
//  Copyright © 2017年 JUSFOUN. All rights reserved.
//

#import "SearchNoResultView.h"

@implementation SearchNoResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = KHexRGB(0xf2f2f2);
        
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(135);
        }];
        label.font = KFont(17);
        label.text = @"未找到符合条件的结果";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGBHex(@"#7a7a7a");
        
        
    }
    return self;
}



@end
