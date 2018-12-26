//
//  ScanView.h
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeScanView.h"
#import "QRCodeScanManager.h"
#import "ResultController.h"
@interface ScanView : UIView


- (instancetype)initWithFrame:(CGRect)frame resultBlock:(ScanResultBlock)block;

- (void)setupQRCodeScanning;

- (void)removeScanningView;

-(void)startScanAnimation;

-(void)stopScanAnimation;


@end
