//
//  BaseSegmentController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "BaseSegmentController.h"
#import "UIView+Extensions.h"
#import "HomeTabModel.h"

//#define RGBColor(r,g,b) RGBAColor(r,g,b,1.0)
//#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static CGFloat const titleScvH = 44;/** 文字栏高度  */
static CGFloat const MaxScale = 1.2;/** 选中文字放大  */

@interface BaseSegmentController ()<UIScrollViewDelegate>

/** 标签按钮  */
@property (strong,nonatomic) NSMutableArray *titleButtonsArr;

/** 文字scrollView（顶端标题栏）  */
@property (nonatomic, strong) UIScrollView *titleScrollView;

/** 控制器scrollView  */
@property (nonatomic, strong) UIScrollView *contentScrollView;

/** 标签文字  */
//@property (nonatomic ,strong) NSArray * titlesArr;
/** 选中的按钮  */
@property (nonatomic ,strong) UIButton * selectedBtn;

/** 选中的按钮下边的线条  */
@property (nonatomic, strong)UIView * lineView;

@property (nonatomic ,strong) UIView *shadowView;


@end

@implementation BaseSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)initializeLinkageListViewController{
    
    //外部更新标签的时候，先要移除之前添加的控制器和视图
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromParentViewController];
    }];
    
    [self addChildViewController];
    [self.view addSubview:self.shadowView];//上边阴影
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    
    [self addTitleButton];
    self.contentScrollView.contentSize = CGSizeMake(_vcTitleArr.count * KDeviceW, 0);
    
}

-(NSMutableArray *)titleButtonsArr{
    
    if(!_titleButtonsArr){
        
        _titleButtonsArr = [NSMutableArray arrayWithCapacity:10];
        
    }
    
    return _titleButtonsArr;
}

- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, 0)];//暂时隐藏线
        _shadowView.backgroundColor = RGBHex(@"#cccccc");
    }
    return _shadowView;
}

-(UIScrollView *)titleScrollView{
    
    if(!_titleScrollView){
        
         CGFloat y  = CGRectGetMaxY(self.shadowView.frame);
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, y, KDeviceW, titleScvH)];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.pagingEnabled = YES;
        _titleScrollView.showsHorizontalScrollIndicator  = NO;
        _titleScrollView.showsVerticalScrollIndicator  = NO;
        _titleScrollView.delegate = self;
        
    }
    
    return _titleScrollView;
}

-(UIScrollView *)contentScrollView{
    
    if(!_contentScrollView){
        
        CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame)+10;
        CGRect rect  = CGRectMake(0, y, KDeviceW, KDeviceH -y-KNavigationBarHeight-self.tabBarController.tabBar.height);
        
        _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
        
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator  = NO;
        _contentScrollView.delegate = self;
        
    }
    
    return _contentScrollView;
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame)+10;
    _contentScrollView.frame = CGRectMake(0, y, KDeviceW, KDeviceH -y-KNavigationBarHeight-self.tabBarController.tabBar.height);
    
}

-(void)addChildViewController{
    
    
}

-(void)addTitleButton{
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat w = KDeviceW / _vcTitleArr.count;
    if (w < 80) {//标题按钮的宽度  >= 80
        
        w = 80;
    }
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 2, w, titleScvH - 6);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rect;
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];

        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:RGBHex(@"#1a1a1a") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.titleButtonsArr addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0){//默认选中第一个
            [self titleClick:btn];
        }
    }
    
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);//titleScrollView的滑动范围
    
    if (self.titleScrollView.contentSize.width/_vcTitleArr.count < 80) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleScvH - 3, 80, 2)];
    }else{
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleScvH - 3, self.titleScrollView.contentSize.width/_vcTitleArr.count, 2)];
    }
    
    self.lineView.backgroundColor = RGBHex(@"#ff0000");
    [self.titleScrollView addSubview:self.lineView];
    
}

-(void)titleClick:(UIButton *)sender{
    
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x  = i * KDeviceW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self setUpOneChildController:i];
}

-(void)selectTitleBtn:(UIButton *)btn{
    
    [self.selectedBtn setTitleColor:RGBHex(@"#1a1a1a") forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:RGBHex(@"#ff0000") forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    
    self.selectedBtn = btn;
    
    //self.lineView.center.x = self.selectedBtn.center.x;
    
    [self setupTitleCenter:btn];
}

//更新 按钮的中心位置
-(void)setupTitleCenter:(UIButton *)sender
{
    //保证数量较少时不会产生异常的偏移！
    if (self.titleScrollView.contentSize.width <= KDeviceW) {
        return;
    }
    
    CGFloat offset = sender.center.x - KDeviceW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - KDeviceW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
//    [UIView animateWithDuration:.3 animations:^{
        self.lineView.centerX = sender.centerX;//使下划线的中心跟随 当前选中的按钮
//    }];
    
}

//给contentScrollView添加当前某个需要显示的 ViewController
-(void)setUpOneChildController:(NSInteger)index{
    
    CGFloat x  = index * KDeviceW;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {//判断是否是父视图
        return;
    }
    vc.view.frame = CGRectMake(x, 0, KDeviceW, self.contentScrollView.height);
    [self.contentScrollView addSubview:vc.view];//将子ViewController 的 View 添加到  contentScrollView 上
}

#pragma mark - UIScrollView  delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        NSInteger i  = self.contentScrollView.contentOffset.x / KDeviceW;
        [self selectTitleBtn:self.titleButtonsArr[i]];
        [self setUpOneChildController:i];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        CGFloat offsetX  = scrollView.contentOffset.x;
        NSInteger leftIndex  = offsetX / KDeviceW;
        NSInteger rightIdex  = leftIndex + 1;
        
        UIButton *leftButton = self.titleButtonsArr[leftIndex];
        UIButton *rightButton  = nil;
        if (rightIdex < self.titleButtonsArr.count) {
            
            rightButton  = self.titleButtonsArr[rightIdex];
        }
        
        CGFloat scaleR  = offsetX / KDeviceW - leftIndex;
        CGFloat scaleL  = 1 - scaleR;
        CGFloat transScale = MaxScale - 1;
        leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
        rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
        
        //修改下划线的frame
        //self.lineView.transform  = CGAffineTransformMakeTranslation((offsetX * (self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
