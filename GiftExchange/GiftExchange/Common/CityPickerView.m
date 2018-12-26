//
//  CityPickerView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CityPickerView.h"

#define MainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]


@interface CityPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong) UIView       *backView;

@property (strong, nonatomic) UIButton     *cancelBtn;

@property (strong, nonatomic) UIButton     *confirmBtn;

@property (strong, nonatomic) UILabel      *addressLb;

@property (strong, nonatomic) UIView       *darkView;

@property (strong, nonatomic) UIBezierPath *bezierPath;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (nonatomic ,strong) NSArray      *list;

@property (nonatomic ,assign) BOOL visible;

@property (nonatomic ,assign) NSInteger row0;

@property (nonatomic ,assign) NSInteger row1;

@property (nonatomic ,assign) NSInteger row2;

@property (nonatomic ,strong) NSArray *cityArray;

@property (nonatomic ,strong) NSArray *townArray;

@end

@implementation CityPickerView


- (instancetype)init{
    if (self = [super init]) {
        
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"json"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _list = [str mj_JSONObject];
    _cityArray = _list[0][@"children"];
    _townArray = _cityArray[0][@"children"];
    
}


- (void)initView{
    
    self.frame = CGRectMake(0, 0, KDeviceW, KDeviceH);

    
    [self addSubview:self.darkView];
    [self addSubview:self.backView];

    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.confirmBtn];
    [self.backView addSubview:self.addressLb];
    [self.backView addSubview:self.pickerView];
    
    [self bezierPath];
    [self shapeLayer];
    
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        
        return [_list count];
        
    }else if (component == 1){

        return [_cityArray count];
        
    }else{

        return [_townArray count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        
        self.cityArray = _list[row][@"children"];
        self.townArray = self.cityArray[0][@"children"];
        
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];

        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }else if (component == 1){
        
        self.townArray = self.cityArray[row][@"children"];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        [pickerView reloadComponent:2];
    }
    
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            
            return _list[row][@"name"];
            break;
            
        case 1:
        {
            
            return _cityArray[row][@"name"];
        }
            break;

        case 2:{
            return _townArray[row][@"name"];
        }
            break;
        default:
            break;
    }
    
    return nil;
}



#pragma mark 隐藏 显示

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint point    = _backView.center;
        point.y          -= 250;
        _backView.center = point;
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)dismiss{
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint point    = _backView.center;
        point.y          += 250;
        _backView.center = point;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)confirmAction{
    NSLog(@"确定");
    
    if ([self anySubViewScrolling:_pickerView]) {
        return;
    }
    [self dismiss];
    
    NSInteger selectRow0 = [_pickerView selectedRowInComponent:0];
    NSInteger selectRow1 = [_pickerView selectedRowInComponent:1];
    NSInteger selectRow2 = [_pickerView selectedRowInComponent:2];
    
    NSString *province = _list[selectRow0][@"name"];
    NSString *city = _cityArray[selectRow1][@"name"];
    NSString *district= _townArray[selectRow2][@"name"];
    
    NSMutableString *result = [NSMutableString string];
    if (![city hasPrefix:province]) {
        [result appendString:province];
    }
    if (city) {
        [result appendString:city];
    }
    
    if (district) {
        [result appendString:district];
    }


    if ([result length]) {
        if ([_delegate respondsToSelector:@selector(cityPickerDidSelectWithAddress:)]) {
            [_delegate cityPickerDidSelectWithAddress:result];
        }
    }
}


- (BOOL)anySubViewScrolling:(UIView *)view{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark lazy load

- (UIView *)darkView {
    if (!_darkView) {
        _darkView                 = [[UIView alloc]init];
        _darkView.frame           = self.frame;
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha           = 0.3;
    }
    return _darkView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView                 = [[UIView alloc]init];
        _backView.frame           = CGRectMake(0, KDeviceH, KDeviceW, 250);
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer          = [[CAShapeLayer alloc] init];
        _shapeLayer.frame    = _backView.bounds;
        _shapeLayer.path     = _bezierPath.CGPath;
        _backView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView                 = [[UIPickerView alloc]init];
        _pickerView.frame           = CGRectMake(0, 50, KDeviceW, 200);
        _pickerView.delegate        = self;
        _pickerView.dataSource      = self;
        _pickerView.backgroundColor = MainBackColor;
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 50, 50);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.frame = CGRectMake(KDeviceW - 50, 0, 50, 50);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UILabel *)addressLb {
    if (!_addressLb) {
        _addressLb               = [[UILabel alloc]init];
        _addressLb.frame         = CGRectMake(50, 0, KDeviceW - 100, 50);
        _addressLb.textAlignment = NSTextAlignmentCenter;
        _addressLb.font          = [UIFont systemFontOfSize:16.0];
    }
    return _addressLb;
}

@end
