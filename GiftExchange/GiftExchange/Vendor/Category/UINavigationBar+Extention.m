//
//  UINavigationBar+Extention.m
//  EnterpriseInquiry
//
//  Created by clj on 16/8/9.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "UINavigationBar+Extention.h"
#import <objc/runtime.h>
const void *MyViewKey = "MyViewKey";
@implementation UINavigationBar (Extention)

- (UIView *)overlay {
    return objc_getAssociatedObject(self, MyViewKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, MyViewKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)fs_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        //        self.translucent = YES;
        [self setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[[UIImage alloc]init]];
        
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
         self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
        self.overlay.userInteractionEnabled=NO;
    }
    self.overlay.backgroundColor = backgroundColor;
}

-(BOOL)backColorIsWhite{
    if (self.overlay.backgroundColor == [UIColor whiteColor]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)fs_clearBackgroudCustomColor{
    if (self.overlay){
        [self.overlay removeFromSuperview];
        self.overlay=nil;
        //        self.translucent = NO;
    }
}

@end
