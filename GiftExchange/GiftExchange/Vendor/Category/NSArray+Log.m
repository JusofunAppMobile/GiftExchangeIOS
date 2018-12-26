//
//  NSArray+Log.m
//  susencloud
//
//  Created by tanchao on 15/11/10.
//  Copyright © 2015年 chaoren. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    [strM appendString:@")"];
    return strM;
}
- (NSArray *)getObjectsFromrange:(NSRange)range{
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < range.length; i++)
    {
        int index = (int)range.location + i;
        if (index < self.count) [result addObject:self[index]];
    }
    return result.copy;
}
@end
@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
     [strM appendFormat:@"\t%@ = %@;\n",key,obj];
    }];
    [strM appendString:@"}\n"];
    return strM;
}
@end