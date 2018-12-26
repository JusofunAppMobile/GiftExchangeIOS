//
//  ScanView.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ScanView.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanView ()
@property (nonatomic, strong) QRCodeScanView *scanningView;

@property(nonatomic,copy)ScanResultBlock scanResultBlock;

@end

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame resultBlock:(ScanResultBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        [self checkPermission];
        
        self.scanResultBlock = block;
        
        [self addSubview:self.scanningView];
    }
    return self;
}



- (void)setupQRCodeScanning {
    
    
    KWeakSelf;
    QRCodeScanManager *manager = [QRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    [manager scanWithMetadataObjectTypes:arr currentController:self resultBlock:^(NSArray *resulutArray) {
        
        [manager stopRunning];
        [weakSelf stopScanAnimation];
       //[manager videoPreviewLayerRemoveFromSuperlayer];
        
        weakSelf.scanResultBlock(resulutArray);
        
//        NSLog(@"%@",resulutArray);
       
    }];
}



#pragma mark - 检查权限
-(void)checkPermission
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        
                        [self setupQRCodeScanning];
                        
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
           
            
            [self setupQRCodeScanning];
            
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            
            NSString *str = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",[dic objectForKey:@"CFBundleDisplayName"]];
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
            
            
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"访问限制");
            
            NSString *str = [NSString stringWithFormat:@"请去-> [设置 - 通用 - 访问限制 - %@] 允许访问",[dic objectForKey:@"CFBundleDisplayName"]];
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
            
        }
    } else {
      
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"未检测到您的摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        
    }
    
}

-(QRCodeScanView *)scanningView
{
    if(!_scanningView)
    {
        _scanningView = [[QRCodeScanView alloc]initWithFrame:self.frame];
    }
    return _scanningView;
}



-(void)startScanAnimation
{
    [self.scanningView startScanAnimation];
    QRCodeScanManager *manager = [QRCodeScanManager sharedManager];
    [manager startRunning];
}

-(void)stopScanAnimation
{
    [self.scanningView stopScanAnimation];
}

- (void)removeScanningView {
    [self.scanningView stopScanAnimation];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}


@end
