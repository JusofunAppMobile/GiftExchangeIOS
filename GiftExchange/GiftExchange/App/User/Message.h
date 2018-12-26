//
//  Message.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
//#import <UserNotifications/UserNotifications.h>

@interface Message : NSObject<UNUserNotificationCenterDelegate>

+ (void)registerRemoteNotification:(id<UNUserNotificationCenterDelegate> )delegate;
@end
