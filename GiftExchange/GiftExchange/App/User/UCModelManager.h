//
//  UCModelManager.h
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCModelManager : NSObject

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSections;

- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath;

- (void)updateModel:(NSString *)phone;
@end
