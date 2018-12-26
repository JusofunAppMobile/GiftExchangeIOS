//
//  NetFailView.h
//  RecruitOnline
//
//  Created by JUSFOUN on 2017/7/14.
//  Copyright © 2017年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NetFailDelegate <NSObject>

- (void)netFailReload;

@end

@interface NetFailView : UIView

@property (nonatomic ,weak) id <NetFailDelegate>delegate;


@end
