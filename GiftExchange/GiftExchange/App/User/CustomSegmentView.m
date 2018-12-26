//
//  CustomSegmentView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/9.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CustomSegmentView.h"

@interface CustomSegmentView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic ,assign) CGFloat addWidth;//按钮附加宽度
@property (nonatomic ,strong) NSMutableArray *buttonArray;
@property (nonatomic ,assign) CGFloat totalTitleWidth;
@property (nonatomic ,strong) UIScrollView *scrollview;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,strong) UIButton *selectedButton;

@end
@implementation CustomSegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _buttonArray = [NSMutableArray array];
        _titleArray = titleArray;
        _addWidth = 20.f;

        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    CGFloat x = 0;
    CGFloat height = self.height;
    
    //滚动视图
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, height)];
    _scrollview.delegate = self;
    [self addSubview:_scrollview];

    //标签按钮
    for (int i= 0; i<[_titleArray count]; i++) {
        
        CGFloat width = [self titleWidth:_titleArray[i]];
        
        UIButton *button = [[UIButton alloc] initWithFrame:KFrame(x ,0 ,width ,height)];
        button.titleLabel.font = KFont(13);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBHex(@"#1a1a1a") forState:UIControlStateNormal];
        [button setTitleColor:RGBHex(@"#ff0000") forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:button];
        [_buttonArray addObject:button];
        _totalTitleWidth = _totalTitleWidth+width;
        
        x += width;
    }
    _scrollview.contentSize = CGSizeMake(MAX(_totalTitleWidth, KDeviceW), height);
    //下划线
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height-2, 40, 2)];
    _lineView.backgroundColor = RGBHex(@"#ff0000");
    [_scrollview addSubview:_lineView];
    
    
    [self buttonAction:_buttonArray[0]];
}

#pragma mark button action点击按钮
- (void)buttonAction:(UIButton *)sender{
    
    if ([sender isEqual:_selectedButton]) {
        return;
    }
    _selectedButton.selected = NO;
    
    _selectedButton = sender;
    _selectedButton.selected = YES;
    
    if (_totalTitleWidth > KDeviceW) {//可以滚动
        if (sender.center.x < KDeviceW/2) {//最左半边
            [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
            [self changeLineViewFrame];
        }else if (sender.center.x > (_totalTitleWidth - KDeviceW / 2)){//最有半边
            [_scrollview setContentOffset:CGPointMake(_totalTitleWidth - KDeviceW, 0) animated:YES];
            [self changeLineViewFrame];
        }else{
            [_scrollview setContentOffset:CGPointMake(sender.center.x - KDeviceW/2, 0) animated:YES];
        }
    }
}

//scroll滚动的时候，等停止再改变下划线位置
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self changeLineViewFrame];
}

- (void)changeLineViewFrame{
    if (_selectedButton) {
        [UIView animateWithDuration:.2 animations:^{
            _lineView.center = CGPointMake(_selectedButton.center.x, _lineView.center.y);
        }];
    }
}

//根据title获取button宽度
- (CGFloat)titleWidth:(NSString *)title{
    //    CGFloat sys_font = _fontScale>1?_fontSize*_fontScale:_fontSize;
    return [title boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.frame)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : KFont(13)} context:nil].size.width + _addWidth;
    return 0;
}






@end
