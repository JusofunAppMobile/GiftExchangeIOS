//
//  BasicViewController.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+Add.h"
#import "UINavigationBar+Extention.h"
#import <MJRefresh.h>
#import "SearchNoResultView.h"
#import "NetFailView.h"

@interface BasicViewController : UIViewController<NetFailDelegate>

/**
 *  设置title
 *
 *  @param title 标题
 */
-(void)setNavigationBarTitle:(NSString *)title;

/**
 *  设置导航文字，自定义字体颜色和内容
 *
 *  @param title 标题
 *  @param color 颜色
 */
-(void)setNavigationBarTitle:(NSString *)title andTextColor:(UIColor *)color;





/**
 设置右侧按钮

 @param title 按钮标题
 @param imageName 按钮图片
 */
-(void)setRightNavigationBarBtnWithTitle:(NSString *)title withImageName:(NSString*)imageName;

-(void)setLeftNavigationBarBtnWithTitle:(NSString *)title withImageName:(NSString*)imageName;

/**
 *  设置返回按钮
 *
 */
-(void)setBackBtn;

/**
 *  返回界面，如需更改子类重写
 */
-(void)back;


-(void)rightBtnAction;

//列表无数据页面
- (void)showNoResultInView:(UIView *)view hidden:(BOOL)hidden;


- (void)showNetFailWithFrame:(CGRect)frame;

- (void)hideNetFailView;










@end
