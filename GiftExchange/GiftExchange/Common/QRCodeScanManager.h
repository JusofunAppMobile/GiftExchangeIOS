//
//  QRCodeScanManager.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/7/20.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ScanResultBlock)(NSArray*resulutArray);

@interface QRCodeScanManager : NSObject

+ (instancetype)sharedManager;

- (void)scanWithMetadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIView *)currentController resultBlock:(ScanResultBlock)block;

- (void)startRunning;

- (void)stopRunning;

- (void)videoPreviewLayerRemoveFromSuperlayer;

@end
