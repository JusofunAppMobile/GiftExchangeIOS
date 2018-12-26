//
//  Tools.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef void (^NavigationBarMessageBlock)(NSDictionary *messageDic);


@interface Tools : NSObject


//方法功能：根据字体大小与限宽，计算高度
+(CGFloat)getHeightWithString:(NSString*)string fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

+(CGFloat)getWidthWithString:(NSString*)string fontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight;

// 生成指定大小的图片
+ (UIImage *)scaleImage:(UIImage*)image size:(CGSize)newsize;

// 生成一张指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)newsize;


+(NSString *) md5:(NSString *)str;

#pragma mark - 四位随机数
+(NSString *)randomNum;
//加密
+ (NSMutableDictionary*)encryptionWithDictionary:(NSMutableDictionary*)dic;

//获取现在的时间
+(NSDate *)GetCurrentTime;

+(int )GetCurrentTimeStamp:(NSDate *)date;


/**
 时间戳转时间
 
 @param timestamp 时间戳
 @return 时间
 */
+(NSString *)timestampSwitchTime:(NSString*)timestamp;


/**
 将字符串返回AttributedString

 @param title      想要处理的字符串
 @param otherColor 不加颜色的字符串的颜色

 @return 处理好的字符串
 */
+(NSMutableAttributedString *)titleNameWithTitle:(NSString *)title otherColor:(UIColor*)otherColor;

@end
