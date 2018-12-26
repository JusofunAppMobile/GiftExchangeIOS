//
//  NSString+Verify.h
//  JIIESTCar
//
//  Created by wzh on 15/12/31.
//  Copyright © 2015年 WZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

- (BOOL)validateMobile;
- (NSMutableAttributedString *)colorForNormal:(UIColor *)normalColor andPhone:(UIColor *)phoneColor;
- (NSMutableAttributedString *)colorFornormal:(UIColor *)normalColor andNumber:(UIColor *)numberColor;
- (NSString *)abovePhone;

- (BOOL)checkUserIdCard;
- (BOOL)checkName;
+ (BOOL)isEmpty:(NSString *)str;
+ (NSString *)removeZeroWithString:(NSString *)str;
+ (NSString *)getFormatString:(NSString *)str;
- (BOOL)checkUnInt;
- (BOOL)checkPositiveNum;
@end
