//
//  RecordLogisticsController.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "RecordLogisticsController.h"

@interface RecordLogisticsController ()
{
    ScanView *scanView;
}
@end

@implementation RecordLogisticsController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setNavigationBarTitle:@"扫描录入"];
    [self setBackBtn];
    [self drawView];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;//使界面从屏幕顶端布局
    
}

-(void)drawView
{
    KWeakSelf;
    scanView = [[ScanView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH) resultBlock:^(NSArray *resulutArray) {
//        NSLog(@"resultArray ==== %@",resulutArray);
        
        [weakSelf back];
        
        if(weakSelf.scanBlock)
        {
            if(resulutArray.count >0)
            {
                AVMetadataMachineReadableCodeObject * metadataObject = [resulutArray objectAtIndex:0];
                weakSelf.scanBlock(metadataObject.stringValue);
            }
        }
        else
        {
            [MBProgressHUD showHint:@"添加成功" toView:nil];
        }
        
    }];
    [self.view addSubview:scanView];
    
   // [scanView setupQRCodeScanning];
}




-(void)viewWillAppear:(BOOL)animated
{
    [scanView startScanAnimation];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [scanView stopScanAnimation];
}

-(void)dealloc
{
    [scanView removeScanningView];
}







@end
