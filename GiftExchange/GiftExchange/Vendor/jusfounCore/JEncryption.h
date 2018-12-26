//
//  JEncryption.h
//  jusfounCore
//
//  Created by AllanXing on 2/16/16.
//  Copyright © 2016 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEncryption : NSObject

+(NSString *)debugEncryptionOutPut:(NSDate *)time;
+(NSString *)releaseEncryptionOutPut:(NSDate *)time;
+(NSDate *)convertHeaderDateToNSDate:(NSString *)headerdate;

@end
