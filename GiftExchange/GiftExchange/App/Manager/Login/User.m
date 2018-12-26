//
//  User.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "User.h"

@implementation User
SingletonM(User);


- (BOOL)isLogin{

    if ([_userId length]) {
        return YES;
    }
    return NO;
}

+ (void)cleanUser{
    KUSER.phone = nil;
    KUSER.type = nil;
    KUSER.userId = nil;
//    [self setPropsToNil];
    [self clearTable];
    [AddressModel clearTable];
}

- (AddressModel *)addrInfo{
    NSArray *array = [AddressModel findAll];
    AddressModel *model = nil;
    if (array.count) {
        model = array[0];
    }
    return model;
}


+ (void)setPropsToNil{
    
    unsigned int outCount;
    objc_property_t *propertys = class_copyPropertyList(self, &outCount);
    
    for (int i= 0; i<outCount; i++) {
        
        objc_property_t prop = propertys[i];
    
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        
        [KUSER setValue:[NSNull null] forKey:propName];
    }
}

- (const char *)getPropType:(objc_property_t)prop{

    const char *attrs = property_getAttributes(prop);
    
    char buffer[1+ strlen(attrs)];
    
    strcpy(buffer, attrs);
    
//    char *state = buffer,*attrs;
    
    
    
    return 0;
}
@end
