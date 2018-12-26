//
//  UINavigationBar+Gradient.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/9/27.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UINavigationBar+Gradient.h"

const void *myKey = @"myKey";

@implementation UINavigationBar (Gradient)

- (CAGradientLayer *)overlay{
    return objc_getAssociatedObject(self, myKey);
}

- (void)setOverlay:(CAGradientLayer *)layer{
    objc_setAssociatedObject(self, myKey, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)wzh_setGradientNavigationBar:(NSArray *)colors{
    if (!self.overlay) {
        //        [self setShadowImage:[[UIImage alloc]init]];
        [self setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors =colors;
        gradientLayer.locations = @[@0.38, @0.67, @0.8f];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + KStatusBarHeight);
        self.overlay = gradientLayer;
        [[self.subviews firstObject].layer insertSublayer:self.overlay atIndex:0];
    }
}

- (void)wzh_clearGradientNavigationBar{
    if (self.overlay) {
        [self.overlay removeFromSuperlayer];
        self.overlay = nil;
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
}

@end
