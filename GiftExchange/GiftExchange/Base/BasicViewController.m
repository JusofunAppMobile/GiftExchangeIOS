//
//  BasicViewController.m
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BasicViewController.h"
#import "UINavigationBar+Gradient.h"

@interface BasicViewController ()

@property (nonatomic ,strong) SearchNoResultView *noResultView;

@property (nonatomic ,strong) NetFailView *netFailView;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = KHexRGB(0xf2f2f2);
    //设置渐变色导航栏
    [self.navigationController.navigationBar wzh_setGradientNavigationBar:@[(__bridge id)RGBHex(@"#ff5b01").CGColor, (__bridge id)RGBHex(@"#ff4b0a").CGColor, (__bridge id)RGBHex(@"#ff251a").CGColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar fs_setBackgroundColor:KNavigationBarBackGroundColor];
}

-(void)setNavigationBarTitle:(NSString *)title
{
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:KNavigationTitleFontSize],NSForegroundColorAttributeName:[UIColor blackColor]}];
//    self.title = title;
    [self setNavigationBarTitle:title andTextColor:[UIColor whiteColor]];
}

/**
 *  设置导航文字，自定义字体颜色和内容
 *
 *  @param title 标题
 *  @param color 颜色
 */
-(void)setNavigationBarTitle:(NSString *)title andTextColor:(UIColor *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:KFont(KNavigationTitleFontSize),NSForegroundColorAttributeName:color}];
    self.navigationItem.title = title;

}


#pragma mark right
//右边导航按钮
-(void)setRightNavigationBarBtnWithTitle:(NSString *)title withImageName:(NSString*)imageName
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    CGFloat titleWidth = 0;
    CGFloat imageWith = 0;
    
    if(title && title.length > 0 ){
        [backBtn setTitle:title forState:UIControlStateNormal];
        titleWidth = [self titleWidth:title];
    }
    if(imageName){
        UIImage *image = KImageName(imageName);
        [backBtn setImage:image forState:UIControlStateNormal];
        imageWith = image.size.width;
    }
    
    
    backBtn.frame = CGRectMake(0, 0,titleWidth+imageWith, 44);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0,10)];
    [backBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = KFont(14);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backItem;
}

//根据title获取button宽度
- (CGFloat)titleWidth:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : KFont(14)} context:nil].size;
    return ceil(size.width);
}
-(void)setLeftNavigationBarBtnWithTitle:(NSString *)title withImageName:(NSString*)imageName
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(title){
        [backBtn setTitle:title forState:UIControlStateNormal];
    }
    if(imageName){
        [backBtn setImage:KImageName(imageName) forState:UIControlStateNormal];
    }
    
    backBtn.frame = CGRectMake(0, 0,70, 40);
    backBtn.titleLabel.font = KFont(12);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0,10)];
    [backBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)leftBtnAction{

    

}

- (void)rightBtnAction{


}

/**
 *  加载失败动画点击重新加载方法
 */
-(void)abnormalViewReload
{
    
}


-(void)setBackBtn
{
    
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backBtn setImage:KImageName(@"查看物流－右箭头") forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 无数据view
- (void)showNoResultInView:(UIView *)view hidden:(BOOL)hidden{
    if (!_noResultView) {
        _noResultView = [[SearchNoResultView alloc]initWithFrame:view.frame];
        [view addSubview:_noResultView];
    }
    _noResultView.hidden = hidden;
    [view bringSubviewToFront:_noResultView];
}


#pragma mark - 网络加载失败view
//网络连接失败
- (void)showNetFailWithFrame:(CGRect)frame{
    if (_netFailView) {
        [_netFailView removeFromSuperview];
        _netFailView = nil;
    }
    
    _netFailView = [[NetFailView alloc]initWithFrame:frame];
    _netFailView.delegate = self;
    [self.view addSubview:_netFailView];
    [self.view bringSubviewToFront:_netFailView];
}

//隐藏
-(void)hideNetFailView{
    if (_netFailView) {
        [_netFailView removeFromSuperview];
        _netFailView = nil;
    }
}

//重新加载
- (void)netFailReload{
    
}

#pragma mark - 屏幕旋转
// 支持屏幕旋转
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait /*| UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight*/);
}

// 不自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

//
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return (UIInterfaceOrientationPortrait /*| UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight*/);
}



@end
