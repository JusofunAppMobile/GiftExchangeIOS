//
//  QRCodeView.h
//  GiftExchange
//
//  Created by JUSFOUN on 2018/4/11.
//  Copyright © 2018年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIView

- (void)showWithString:(NSString *)str;

- (void)dismiss;

@end
