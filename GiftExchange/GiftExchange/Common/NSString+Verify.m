//
//  NSString+Verify.m
//  JIIESTCar
//
//  Created by wzh on 15/12/31.
//  Copyright © 2015年 WZH. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

//判断非负整数
- (BOOL)checkUnInt{
    NSString *MOBILE = @"^[1-9]\\d*|0$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:self]) {
        return YES;
    }else {
        return NO;
    }
}

//判断正整数
- (BOOL)checkPositiveNum{
    NSString *MOBILE = @"^[1-9]\\d*$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:self]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)validateMobile{
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:self]) {
        return YES;
    }else {
        return NO;
    }
}
- (NSString *)abovePhone{
    NSString *str = nil;
    if (self.length<=11) {
        
        return str;
    }
    for (int i = 0; i <= self.length-11; i++)
    {
        NSRange range = NSMakeRange(i, 11);
        NSString *str1 = [self substringWithRange:range];
        if ([str1 validateMobile])
        {
            str = str1;
            break;
        }
        
    }
    return str;
}
-(NSMutableAttributedString *)colorForNormal:(UIColor *)normalColor andPhone:(UIColor *)phoneColor{
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:self];
    [attributedString addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, self.length)];
    if (self.length<=11) {
        
        return attributedString;
    }
    for (int i = 0; i <= self.length-11; i++)
    {
        NSRange range = NSMakeRange(i, 11);
        NSString *str1 = [self substringWithRange:range];
        if ([str1 validateMobile])
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:phoneColor range:range];
            break;
        }
        
    }
    return attributedString;
}

- (BOOL)isPureInts{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(NSMutableAttributedString *)colorFornormal:(UIColor *)normalColor andNumber:(UIColor *)numberColor{
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:self];
    for (int i = 0; i < self.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *str1 = [self substringWithRange:range];
        if ([str1 isPureInts])
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:RGBHex(@"#ff4536") range:range];
        }
        
    }
    return attributedString;
}

- (BOOL)checkUserIdCard{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    if (self.length <= 0)
        return NO;
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)checkName{
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z ]+$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

+ (BOOL) isEmpty:(NSString *)str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (NSString *)removeZeroWithString:(NSString *)str{
    NSUInteger length = [str length];
    for(int i = 1; i<=length; i++) {
        NSString *subString = [str substringFromIndex:length - i];
        if(![subString isEqualToString:@"0"]){
            if ([subString isEqualToString:@"."]) {
                str = [str substringToIndex:length-i];
            }
            return str;
        }else{
            str = [str substringToIndex:length - i];
        }
    }
    return str;
}

+ (NSString *)getFormatString:(NSString *)str{
    NSString *newStr = [NSString stringWithFormat:@"%@",str];//number转str
    NSString *outNumber = @"0";
    if (newStr.doubleValue>99999999) {
        outNumber = @"99999999+";
    }else{
        outNumber = [NSString removeZeroWithString:newStr];
    }
    return outNumber;
}

@end
